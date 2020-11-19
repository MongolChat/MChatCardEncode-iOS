# MChatCardEncode-iOS
MongolPay картын дугаарыг Encrypt  хийх

### Яаж суулгах вэ?

Source дотор байгаа Файлуудыг өөрийн Project-дээ нэмнэ

### Яаж хэрэглэх вэ?

```objc
 NSString *cardNumber = @"9496123412341234";
 NSString *encryptedString = [[number dataUsingEncoding:NSUTF8StringEncoding] encryptPKCS1ForTokenEx];;
```
