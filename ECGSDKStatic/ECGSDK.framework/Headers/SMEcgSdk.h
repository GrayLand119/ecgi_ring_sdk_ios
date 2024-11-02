//
//  SMEcgSdk.h
//  ECG SDK
//
//  Created by GuilinLan on 2024/9/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SMStateCode) {
    SMStateCodeUnregistered = -1,
    SMStateCodeSuccess = 0,
    SMStateCodeExpiredKey = 10001,
    SMStateCodeInvalidKey,
};

@interface SMEcgSdk : NSObject

@property (nonatomic, assign, readonly) SMStateCode stateCode;

+ (instancetype)shared;

+ (NSString *)version;
- (NSString *)version;


/// 注册 SDK
/// - Parameter apiKey: YOUR_API_KEY_STRING
- (void)registerWithKey:(NSString *)apiKey;

/// 实时算法
/// 实时采集心电时可以调用此算法
/// - Parameters:
///   - rawData: 原始心电数据
///   - fs: 采样率
/// - Returns:
///     - array[0]: 处理后的心电数据
///     - array[1]: 平均心率
- (NSArray *)realtimeProcess:(NSArray<NSNumber *> *)rawData fs:(double)fs;

/// 诊断算法
/// 传入 30~300 秒的心电数据, 计算后返回诊断结果
/// - Parameters:
///   - rawData: 原始心电数据
///   - fs: 采样率
///
/// - Returns resultArray:
///   - resultArray[0]: 处理后的心电数据
///   - resultArray[1]: 心率相关信息 see [README#心率相关信息]
///   - resultArray[2]: 心律(节律)相关信息 see [README#心律相关信息]
/// hrInfo:
/// 0. minHR
/// 1. meanHR
/// 2. maxHR
/// 3. minRR(ms)
/// 4. meanRR(ms)
/// 5. maxRR(ms)
/// 6. PR间期(ms)
/// 7. QRS 波宽(ms)
/// 8. SDNN
/// 9. RMSSD
/// 10. 漏搏数量
/// 11. 室性早搏数量
/// 12. 室上性早搏数量
/// TypeIndex
/// 0. 正常
/// 1. 房扑
/// 2. 房颤
/// 3. 室颤/室扑
/// 4. 其他心律不齐
/// 5. 噪声
/// 6. 含有室上性早搏
/// 7. 含有室性早搏
- (NSArray<NSArray<NSNumber *> *>*)diagnose:(NSArray<NSNumber *> *)rawData fs:(double)fs;

/// 清空并重置缓冲区
- (void)resetBuffer;

/// 内置缓冲区的实时算法
///
/// - 开始处理前请先试用 `resetBuffer` 清空缓冲区.
/// - 当缓冲区不足 3 秒时, 返回[原始数据, 心率 0]
/// - 数据长度>3秒后, 返回[最新 rawData 对应的滤波后数据,心率]
/// - 每次至少传入 10 个点, 但不建议过于频繁计算浪费资源, 一般 1 秒算一次就够了.
///
/// - Parameters:
///   - rawData: 原始数据
///   - fs: 采样率(Hz)
- (NSArray *)continueProcess:(NSArray<NSNumber *> *)rawData fs:(double)fs;

/// 读取心电数据
/// 支持文本形式的数据, 分隔符为换行符
/// - Parameter filePath: 文件路径
- (NSArray <NSNumber *> *)readCSV:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
