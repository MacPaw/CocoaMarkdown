//
//  CMTextView.h
//  CocoaMarkdown-Mac
//
//  Created by Anton Barkov on 7/22/19.
//  Copyright © 2019 Setapp Limited. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMTextView : NSTextView
@property (nonatomic, strong) NSString *markdownString;
@property (nonatomic, strong) NSDictionary<NSAttributedStringKey, id> *customTextAttributes;
@property (nonatomic, strong) NSDictionary<NSAttributedStringKey, id> *customLinkAttributes;
- (void)setCustomAttributes:(NSDictionary<NSAttributedStringKey, id> *)attributes
        forHeaderWithNumber:(NSUInteger)headerNumber;
@end

NS_ASSUME_NONNULL_END
