//
//  NSData+Encryption.h
//  MChat
//
//  Created by Gantulga on 4/20/18.
//  Copyright © 2018 Infinite LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAEncryption : NSObject

- (NSData *)encryptRsaPKCS1:(NSData *)data withPubkeyRef:(SecKeyRef)pubkeyRef;
- (SecKeyRef)keyRefOfRSAKeyWithTag:(NSString *)keyTag;
- (BOOL)addPublicKey:(NSString *)publicKey publicKeyTag:(NSString *)publicKeyTag;
- (BOOL)deleteRSAKeyWithTag:(NSString *)keyTag;
- (BOOL)hasRSAKeyWithTag:(NSString *)keyTag;

@end
