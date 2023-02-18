//
//  RCTCalendarModule.m
//  MyApp
//
//  Created by Abhishek Kumar on 17/02/23.
//

#import <Foundation/Foundation.h>
#import "RCTCalendarModule.h"
#import <React/RCTLog.h>
#import <CommonCrypto/CommonDigest.h>

@implementation RCTCalendarModule

// To export a module named RCTCalendarModule
RCT_EXPORT_MODULE();

//RCT_EXPORT_METHOD(createCalendarEvent:(NSString *)name location:(NSString *)location)
//{
//  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
//}

RCT_EXPORT_METHOD(createCalendarEvent:(NSString *)title
                 location:(NSString *)location
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  NSInteger eventId = 10;
  RCTLogInfo(@"Pretending to create an event %@ at %@", title, location);
  if (eventId) {
      resolve(@(eventId));
  } else {
      reject(@"event_failure", @"no event id returned", nil);
  }
}

//RCT_EXPORT_METHOD(multiply:(nonnull NSNumber *)num1 num2:(nonnull NSNumber *)num2
//                  resolver:(RCTPromiseResolveBlock)resolve
//                  rejecter:(RCTPromiseRejectBlock)reject)
//{
//  RCTLogInfo(@"Inside native Multiply");
//    double result = num1.doubleValue * num2.doubleValue;
//    if (result >= 0) {
//        RCTLogInfo(@"%a", result);
//        return resolve(@(result));
//    } else {
//        NSString *errorMessage = @"Result cannot be negative.";
//        NSError *error = [[NSError alloc] initWithDomain:@"MyModule" code:0 userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
//        return reject(@"negative_result", errorMessage, error);
//    }
//}

RCT_EXPORT_METHOD(multiply:(nonnull NSNumber *)number1
                  withNumber:(nonnull NSNumber *)number2
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  // Convert the input parameters to integer values
  NSInteger int1 = [number1 integerValue];
  NSInteger int2 = [number2 integerValue];

  // Multiply the numbers
  NSInteger result = int1 * int2;

  // Convert the result to a string
  NSString *resultString = [NSString stringWithFormat:@"%ld", (long)result];

  // Resolve the promise with the result
  RCTLogInfo(@"Multiply Output Native%@ ", resultString);
  if(resultString) {
    resolve(resultString);
  }else {
    
  }
}


RCT_EXPORT_METHOD(xor:(NSString *)string1 string2:(NSString *)string2
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  RCTLogInfo(@"Inside native Xor");
    NSData *data1 = [string1 dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2 = [string2 dataUsingEncoding:NSUTF8StringEncoding];
    const char *bytes1 = data1.bytes;
    const char *bytes2 = data2.bytes;
    NSUInteger length1 = data1.length;
    NSUInteger length2 = data2.length;
    NSMutableString *result = [NSMutableString string];
    
    // XOR each byte in the two strings
    NSUInteger minLength = MIN(length1, length2);
    for (NSUInteger i = 0; i < minLength; i++) {
        char xorByte = bytes1[i] ^ bytes2[i];
        [result appendFormat:@"%02x", (unsigned char)xorByte];
    }
    
    // Append any remaining bytes from the longer string
    if (length1 > length2) {
        [result appendString:[string1 substringFromIndex:length2]];
    } else if (length2 > length1) {
        [result appendString:[string2 substringFromIndex:length1]];
    }
   RCTLogInfo(@"Xor Output%@ ", result);
    resolve(result);
}

RCT_EXPORT_METHOD(sha512:(NSString *)string
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    const char *cString = [string UTF8String];
    unsigned char digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(cString, (CC_LONG)strlen(cString), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    RCTLogInfo(@"shaOut %@", result);
    resolve(result);
}

//RCT_EXPORT_METHOD(multiply:(int)num1 num2:(int)num2
//                  resolver:(RCTPromiseResolveBlock)resolve
//                  rejecter:(RCTPromiseRejectBlock)reject)
//{
//    int result = num1 * num2;
//    if (result >= 0) {
//        resolve(@(result));
//    } else {
//        NSString *errorMessage = @"Result cannot be negative.";
//        NSError *error = [[NSError alloc] initWithDomain:@"MyModule" code:0 userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
//        reject(@"negative_result", errorMessage, error);
//    }
//}

@end
