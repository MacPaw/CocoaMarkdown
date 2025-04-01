//
//  CMNodeKey.h
//  CocoaMarkdown
//
//  Created by Anton Barkov on 8/13/19.
//  Copyright © 2019 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaMarkdown/CMNode.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMNodeKey : NSObject <NSCopying>
@property (nonatomic, assign, readonly) CMNodeType nodeType;
@property (nonatomic, assign, readonly) NSUInteger headerLevel;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithNodeType:(CMNodeType)nodeType
                     headerLevel:(NSUInteger)headerLevel;
@end

NS_ASSUME_NONNULL_END
