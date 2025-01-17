#import "RNCloudPayments.h"
#import "SDK/Card.m"
#import "SDK/PKPaymentConverter.m"

@implementation RNCloudPayments

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(isValidNumber: (NSString *)cardNumber
                  cardExp: (NSString *)cardExp
                  cardCvv: (NSString *)cardCvv
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    if([Card isCardNumberValid: cardNumber]) {
        resolve(@YES);
    } else {
        resolve(@NO);
    }
};

RCT_EXPORT_METHOD(getType: (NSString *)cardNumber
                  cardExp: (NSString *)cardExp
                  cardCvv: (NSString *)cardCvv
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    CardType cardType = [Card cardTypeFromCardNumber: cardNumber];
    NSString *cardTypeString = [Card cardTypeToString: cardType];

    resolve(cardTypeString);
}

RCT_EXPORT_METHOD(createCryptogram: (NSString *)cardNumber
                  cardExp: (NSString *)cardExp
                  cardCvv: (NSString *)cardCvv
                  publicId: (NSString *)publicId
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    Card *_card = [[Card alloc] init];

    NSString *cryptogram = [_card makeCardCryptogramPacket: cardNumber andExpDate:cardExp andCVV:cardCvv andMerchantPublicID:publicId];

    resolve(cryptogram);
}

RCT_EXPORT_METHOD(convertToString: (PKPayment *)payment
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    NSString *cryptogram = [PKPaymentConverter convertToString:payment]

    resolve(cryptogram);
}
@end
