//
//  ReceiptEnum.h
//  OCPurchase
//
//  Created by Quan Li on 2020/6/10.
//  Copyright © 2020 Quan.Li. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,ReceiptValidatorType) {
    ReceiptProduction = 0,
    ReceiptSandbox
};

typedef NS_ENUM(NSInteger,ReceiptStatus) {
    // 未知错误
    Unknown = -2,
    // 没有状态返回
    None = -1,
    // 有效状态
    Valid = 0,
    // 未使用HTTP POST请求方法向App Store发送请求
    NoUserPostMethod = 21000,
    // 收据数据属性中的数据格式错误，或者服务遇到临时问题。 再试一次
    MalformedOrMissingData = 21002,
    // 收据无法认证
    ReceiptCouldNotBeAuthenticated = 21003,
    // 您提供的共享密码与您帐户的文件共享密码不匹配。也就是sharedSecret不正确
    SecretNotMatching = 21004,
    // 收据服务器暂时无法提供收据。 再试一次
    ReceiptServerUnavailable = 21005,
    // 该收据有效，但订阅已过期。 当此状态代码返回到您的服务器时，收据数据也会被解码并作为响应的一部分返回。 仅针对自动续订的iOS 6样式的交易收据返回
    SubscriptionExpired = 21006,
    // 该收据来自测试环境，但已发送到生产环境以进行验证
    SandboxEnvironment = 21007,
    // 该收据来自生产环境，但是已发送到测试环境以进行验证
    ProductionEnvironment = 21008,
    // 内部数据访问错误。 稍后再试
    InternalDataAccessError = 21009,
    // 找不到或删除了该用户帐户
    UserAccountNoFound = 21010
};

