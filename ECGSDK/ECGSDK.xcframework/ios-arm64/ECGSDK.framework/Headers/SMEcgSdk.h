//
//  SMEcgSdk.h
//  ECG SDK
//
//  Created by GuilinLan on 2024/9/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMEcgSdk : NSObject

+ (instancetype)shared;

+ (NSString *)version;
- (NSString *)version;

- (NSInteger)sdkTest:(NSInteger)value;

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
/// - Returns:
///   - resultArray 一组数据, 其中:
///   - resultArray[0]: 处理后的心电数据
///   - resultArray[1]: 心率相关信息 see [README#心率相关信息]
///   - resultArray[2]: 心律(节律)相关信息 see [README#心律相关信息]
- (NSArray<NSArray<NSNumber *> *>*)diagnose:(NSArray<NSNumber *> *)rawData fs:(double)fs;


/// 读取心电数据
/// 支持文本形式的数据, 分隔符为换行符
/// - Parameter filePath: 文件路径
- (NSArray <NSNumber *> *)readCSV:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
