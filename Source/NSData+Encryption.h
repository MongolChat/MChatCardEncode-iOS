//
//  NSData+Encryption.h
//  MChat
//
//  Created by Gantulga on 4/20/18.
//  Copyright © 2018 Infinite LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSData (Encryption)

- (NSString *)encryptPKCS1ForTokenEx;
//- (NSDictionary *)encrypt:(NSString *)key withPublicKeyTag:(NSString *)tag;
//- (NSDictionary *)decrypt:(NSString *)tag withKey1:(NSData *)key1 withKey2:(NSData *)key2;
//

@end
