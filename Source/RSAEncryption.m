//
//  NSData+Encryption.h
//  MChat
//
//  Created by Gantulga on 4/20/18.
//  Copyright © 2018 Infinite LLC. All rights reserved.
//

#import "RSAEncryption.h"
#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>

@implementation RSAEncryption

- (NSData *)encryptRsaPKCS1:(NSData *)data withPubkeyRef:(SecKeyRef)pubkeyRef {
    size_t cipherTextSize = SecKeyGetBlockSize(pubkeyRef);
    uint8_t *cipherText = malloc(cipherTextSize);
    memset(cipherText, 0, cipherTextSize);
    SecKeyEncrypt(pubkeyRef, kSecPaddingPKCS1, [data bytes], data.length, cipherText, &cipherTextSize);
    return [NSData dataWithBytes:(const void *)cipherText length:cipherTextSize];
}

- (SecKeyRef)keyRefOfRSAKeyWithTag:(NSString *)keyTag {
    NSAssert(keyTag.length > 0, @"key tag should be non-empty!");
    NSDictionary *query = @{
                            (__bridge id)kSecClass: (__bridge id)kSecClassKey,
                            (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeRSA,
                            (__bridge id)kSecReturnRef: @YES,
                            (__bridge id)kSecAttrApplicationTag: [keyTag dataUsingEncoding:NSUTF8StringEncoding],
                            (__bridge id)kSecAttrAccessible: (__bridge id)kSecAttrAccessibleAlways
                            };
    SecKeyRef KeyRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&KeyRef);
    if (status != errSecSuccess) {
        return NULL;
    }
    
    return KeyRef;
}

- (BOOL)addPublicKey:(NSString *)publicKey publicKeyTag:(NSString *)publicKeyTag {
    NSMutableDictionary *publicDictionary = [[NSMutableDictionary alloc] init];
    [publicDictionary setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicDictionary setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicDictionary setObject:(__bridge id) kSecAttrAccessibleAlways forKey:(__bridge id)kSecAttrAccessible];
    [publicDictionary setObject:publicKeyTag forKey:(__bridge id)kSecAttrApplicationTag];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:[publicKey stringByReplacingOccurrencesOfString:@"\n" withString:@""] options:0];
    [publicDictionary setObject:data forKey:(__bridge id)kSecValueData];
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicDictionary, &persistKey);
    if (status != errSecSuccess){
        NSLog(@"error on public key saving");
    }
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    return status == errSecSuccess;
}

- (BOOL)deleteRSAKeyWithTag:(NSString *)keyTag {
    NSAssert(keyTag.length > 0, @"key tag should be non-empty!");
    NSDictionary *deleteKeyQuery = @{
                                     (__bridge id)kSecClass: (__bridge id)kSecClassKey,
                                     (__bridge id)kSecAttrApplicationTag: [keyTag dataUsingEncoding:NSUTF8StringEncoding],
                                     (__bridge id)kSecAttrType: (__bridge id)kSecAttrKeyTypeRSA,
                                     (__bridge id)kSecAttrAccessible: (__bridge id)kSecAttrAccessibleAlways
                                     };
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)deleteKeyQuery);
    if (status != errSecSuccess){
        NSLog(@"error on key delete");
    }
    return status == errSecSuccess;
}

- (BOOL)hasRSAKeyWithTag:(NSString *)keyTag {
    NSAssert(keyTag.length > 0, @"key tag should be non-empty!");
    
    NSDictionary *publicKeyQuery = @{
                                     (__bridge id)kSecClass: (__bridge id)kSecClassKey,
                                     (__bridge id)kSecAttrApplicationTag: [keyTag dataUsingEncoding:NSUTF8StringEncoding],
                                     (__bridge id)kSecAttrType: (__bridge id)kSecAttrKeyTypeRSA,
                                     (__bridge id)kSecReturnData: @NO,
                                     (__bridge id)kSecAttrAccessible: (__bridge id)kSecAttrAccessibleAlways
                                     };
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKeyQuery, NULL);
    return status == errSecSuccess;
}

@end
