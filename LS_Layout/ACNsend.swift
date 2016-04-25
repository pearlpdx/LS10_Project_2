//
//  ACNsend.swift
//  LS_2016
//
//  Created by Home on 1/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import Foundation
import UIKit

var y = 0

class ACNsend: NSObject {
    
    
    let uDIDstring = UIDevice.currentDevice().identifierForVendor!.UUIDString
    
    private var acnTimer = NSTimer()
    
    private var seqNum = 0
    
    private var _dmxLevels: [UInt8]!
    private var _universe: UInt16!
    
    

    
    func startTimer (dmxlevels: [UInt8], universe: UInt16) {
        self._dmxLevels = dmxlevels
        self._universe = universe
        
        let interval:NSTimeInterval = 1.0 / (Double(REFRESH_PER_10TH) * 10)
  
        acnTimer = NSTimer(timeInterval: interval, target: self, selector: #selector (ACNsend.updateDMX), userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(acnTimer, forMode: NSRunLoopCommonModes)
    }
    
    
    func updateDMX() {
  
        let INADDR = in_addr(s_addr: 16842735)
        let PORT: UInt16 = 5568
        
        
        // Just for a test
//        var x = 0
//        for fix:Fixture in fixtures {
//
//            _dmxLevels[x] = UInt8(fix.indLevel * 255)
//            x = x + 1
//            
//            // test final level
//            fix.finalLevel = fix.finalLevel + 0.0005
//            if fix.finalLevel > 1.0 {
//                fix.finalLevel = 0.0
//            }
//        }
        
        //reset highest level in all channels  (this can go when the Cue Level is pushed)
        for fix in fixtures {
            for (_, chan) in fix.channelDic {
                chan.resetHighestLevels()
            }
        }
        
        //Refresh SubMasters
        for sub in subMasters {
            sub.timerTick()
        }
        
        //refresh display 10 (40/4) a second
        y = y + 1
        if y == 3 {
            y = 0
            NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: nil, userInfo: nil)
        }
        
        
      // Send sACN datagram
        let data:[UInt8] = buildDataGram(self._dmxLevels, optionFlag: false, universe: self._universe)
        
        udpSend(data, address: INADDR, port: PORT)
    }
    
    
    func buildDataGram(dmxLevels: [UInt8], optionFlag: Bool, universe: UInt16) -> [UInt8]  {
        
        var dataG: [UInt8] = [
            0, 0x10,                                                            //Preamble Size         0,1
            0, 0,                                                               //Postamble Size        2,3
            0x41, 0x53, 0x43, 0x2d, 0x45, 0x31, 0x2e, 0x31, 0x37, 0, 0, 0,      //ACN Packet Identifier 4-15
            0,0,                                                                //Flags & Lenth (later) 16,17
            0, 0, 0, 4,                                                         //Vector                18-21
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,              //CID  (work on this    22-37
            0, 0,                                                               //Flags & Lenth (later) 38,39
            0, 0, 0, 2,                                                          //Vector                40-43
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,                     //Source Name           44, 107
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            100,                                                                //Priority              108
            0, 0,                                                               //Reserved              109-110
            0,                                                                  //Seg Number (later)    111
            0,                                                                  //Option (later)        112
            0, 1,                                                               //Universe (later)      113,114
            0,0,                                                                //Flags & Lenth (later) 115,116
            2,                                                                  //Vector                117
            0xa1,                                                               //format of add/data    118
            0, 0,                                                               //Flags and Priority    119,129
            0, 1,                                                               //Address Inc           121-122
            0, 0,                                                               //DMX count +1 (later)  123-124
            0                                                                   //Start Code
        ]
        
        dataG.appendContentsOf(dmxLevels)
        
        //Source name
        var x = 0
        for char in SOURCE_NAME.utf8 {
            
            dataG[44 + x] = char
            x += 1
        }
        
        //CID

        
         x = 0
        for char in uDIDstring.utf8 {
            
            if x <= 15 {
            dataG[22 + x] = char
            }
            x += 1
        }

      
        
        
        
        
        //Flags and Length
        let fAndL: UInt16 = UInt16(dataG.count) | 0x0700
        
        dataG[38] = UInt8((fAndL >> 8) & 0xff)
        dataG[39] = UInt8(fAndL & 0xff)
        dataG[115] = dataG[38]
        dataG[116] = dataG[39]
        dataG[16] = dataG[38]
        dataG[17] = dataG[39]
        
        //Universe
        dataG[113] = UInt8((universe >> 8) & 0xff)
        dataG[114] = UInt8(universe & 0xff)
        
        //Seg Number
        dataG[111] = UInt8(seqNum & 0xff)
        
        //DMX conunt
        dataG[123] = UInt8(((dmxLevels.count + 1) >> 8) & 0xff)
        dataG[124] = UInt8((dmxLevels.count + 1) & 0xff)
        
        seqNum += 1
        
        return dataG
    }
    
    
    
    func udpSend(dataGram: [UInt8], address: in_addr, port: CUnsignedShort) {
   
        
        func htons(value: CUnsignedShort) -> CUnsignedShort {
            return (value << 8) + (value >> 8);
        }
        
        let fd = socket(AF_INET, SOCK_DGRAM, 0) // DGRAM makes it UDP
        
        var addr = sockaddr_in(
            sin_len:    __uint8_t(sizeof(sockaddr_in)),
            sin_family: sa_family_t(AF_INET),
            sin_port:   htons(port),
            sin_addr:   address,
            sin_zero:   ( 0, 0, 0, 0, 0, 0, 0, 0 )
        )
        
        withUnsafePointer(&addr) { ptr -> Void in
            let addrptr = UnsafePointer<sockaddr>(ptr)
            
            sendto(fd, dataGram, dataGram.count, 0, addrptr, socklen_t(addr.sin_len))
            
        }
        
        close(fd)
    }
}


