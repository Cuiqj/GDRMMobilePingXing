//
//  NSString+Base64.m
//  GDRMMobile
//
//  Created by maijunjin on 14-11-20.
//
//

#import "NSString+Base64.h"

@implementation NSString (Base64)
//from: http://cocoadev.com/BaseSixtyFour
+ (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] ;
}

/**
//Base64形式的NSData解密成Base64形式的字符串
NSString *base64String = [base64Data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

// Base64形式的NSData解密成普通字符串
NSData *data = [[NSData alloc] initWithBase64EncodedData:base64Data options:NSDataBase64DecodingIgnoreUnknownCharacters];
NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
*/

/**
// Base64形式的字符串为data
NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];

// Base64形式的NSData转换为data
data = [[NSData alloc] initWithBase64EncodedData:base64Data options:NSDataBase64DecodingIgnoreUnknownCharacters];

// 图片数据
UIImage *image = [[UIImage alloc] initWithData:data];

*/
@end
