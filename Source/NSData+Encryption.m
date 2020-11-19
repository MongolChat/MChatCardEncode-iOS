//
//  NSData+Encryption.h
//  MChat
//
//  Created by Gantulga on 4/20/18.
//  Copyright © 2018 Infinite LLC. All rights reserved.
//

#import "NSData+Encryption.h"
#import "RSAEncryption.h"

#define tokenExTestKey @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvWpIQFjQQCPpaIlJKpegirp5kLkzLB1AxHmnLk73D3TJbAGqr1QmlsWDBtMPMRpdzzUM7ZwX3kzhIuATV4Pe7RKp3nZlVmcrT0YCQXBrTwqZNh775z58GP2kZs+gVfNqBampJPzSB/hB62KkByhECn6grrRjiAVwJyZVEvs/2vrxaEpO+aE16emtX12RgI5JdzdOiNyZEQteU6zRBRJEocPWVxExaOpVVVJ5+UnW0LcalzA+lRGRTrQJ5JguAPiAOzRPTK/lYFFpCAl/F8wtoAVG1c8zO2NcQ0Pko+fmeidRFxJ/did2btV+9Mkze3mBphwFmvnxa35LF+Cs/XJHDwIDAQAB"

#define tokenExProdKey @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8gGPMwBRPuVyJReZGIkWH/+Bf5pnpDN1bSR2cLYLXVT8CaSnTw74qeboSnktgYCi1D9R3Bj2fYzTIwGGZb8KinLdxwbqZmHwrE9cFhCaHbG/E0PbqQGhXP2vbniZTT4M0i0Cbi7ES3Bw5zqNbIZZnX041QEpxLvIyWPKZCX+fBogNMhWfCF779aclChjHkwZMsufThVWE9xklWGxXiytx5aL4I5JPxq0I7cAkZGGs4aF/GxWwPaq7R3wPikJQ0YHnCMfcURzl2Hnw/inqyMy+JB6djTq2/BdzMAhWTh3cDWq9Xu+gEkb/QCd0n1yYIdKuDISlk/AfHdWe34IvzhVyQIDAQAB"

static NSString *tokenExKey = YES ? tokenExTestKey : tokenExProdKey;

@implementation NSData (Encryption)

- (NSString *)tagForTokenX {
    return [NSString stringWithFormat:@"%@TokenExRSATag", [[NSBundle mainBundle] bundleIdentifier]];
}

- (NSString *)encryptPKCS1ForTokenEx {
    RSAEncryption *rsa = [[RSAEncryption alloc] init];
    [rsa deleteRSAKeyWithTag:[self tagForTokenX]];
    if (![rsa hasRSAKeyWithTag:[self tagForTokenX]]) {
        [rsa addPublicKey:tokenExKey publicKeyTag:[self tagForTokenX]];
    }
    NSData *encryptedData = [rsa encryptRsaPKCS1:self
                                   withPubkeyRef:[rsa keyRefOfRSAKeyWithTag:[self tagForTokenX]]];
    return [encryptedData base64EncodedStringWithOptions:0];
}

@end
