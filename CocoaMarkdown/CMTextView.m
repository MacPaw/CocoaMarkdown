//
//  CMTextView.m
//  CocoaMarkdown-Mac
//
//  Created by Anton Barkov on 7/22/19.
//  Copyright © 2019 Setapp Limited. All rights reserved.
//

#import "CMTextView.h"
#import "CMTextAttributes.h"
#import "CMAttributedStringRenderer.h"
#import "CMDocument.h"

@interface CMTextView()
@property (nonatomic, strong) CMTextAttributes *markdownAttributes;
@end

@implementation CMTextView

#pragma mark - Public

- (void)setMarkdownString:(NSString *)markdownString
{
    _markdownString = markdownString;
    [self renderMarkdown];
}

- (void)setCustomTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)customTextAttributes
{
    _customTextAttributes = customTextAttributes;
    [self updateAttributesForKeyPath:@"textAttributes" withDictionary:customTextAttributes];
}

- (void)setCustomLinkAttributes:(NSDictionary<NSAttributedStringKey,id> *)customLinkAttributes
{
    _customLinkAttributes = customLinkAttributes;
    [self updateAttributesForKeyPath:@"linkAttributes" withDictionary:customLinkAttributes];
}

- (void)setCustomAttributes:(NSDictionary<NSAttributedStringKey,id> *)attributes forHeaderWithNumber:(NSUInteger)headerNumber
{
    if (headerNumber < 1 || headerNumber > 6)
    {
        return;
    }
    
    NSString *keyPath = [NSString stringWithFormat:@"h%luAttributes", headerNumber];
    [self updateAttributesForKeyPath:keyPath withDictionary:attributes];
}

#pragma mark - Init

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

#pragma mark - Private

- (void)commonInit
{
    self.verticallyResizable = NO;
    self.horizontallyResizable = NO;
    self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.editable = NO;
    self.drawsBackground = NO;
    self.selectable = YES;
    [self setupTextAttributes];
}

- (void)setupTextAttributes
{
    NSColor *defaultTextColor = [NSColor respondsToSelector:@selector(defaultMarkdownTextColor)] ? NSColor.defaultMarkdownTextColor : NSColor.blackColor;
    NSColor *defaultLinkColor = [NSColor respondsToSelector:@selector(defaultMarkdownLinkColor)] ? NSColor.defaultMarkdownLinkColor : NSColor.blueColor;
    
    CMTextAttributes *defaultAttributes = [CMTextAttributes new];
    defaultAttributes.textAttributes = @{ NSFontAttributeName: [NSFont systemFontOfSize:13],
                                          NSForegroundColorAttributeName: defaultTextColor };
    defaultAttributes.linkAttributes = @{ NSForegroundColorAttributeName: defaultLinkColor,
                                          NSCursorAttributeName: NSCursor.pointingHandCursor };
    self.markdownAttributes = defaultAttributes;
    
    // Remove NSTextView default link attributes so it won't override the NSAttributedString attributes
    [self setLinkTextAttributes:@{}];
}

- (NSSize)intrinsicContentSize
{
    NSTextContainer *textContainer = [self textContainer];
    NSLayoutManager *layoutManager = [self layoutManager];
    [layoutManager ensureLayoutForTextContainer: textContainer];
    return [layoutManager usedRectForTextContainer: textContainer].size;
}

- (void)didChangeText
{
    [super didChangeText];
    [self invalidateIntrinsicContentSize];
}

- (void)updateAttributesForKeyPath:(NSString *)keyPath withDictionary:(NSDictionary *)dictionary
{
    NSDictionary *currentAttributes = [self.markdownAttributes valueForKeyPath:keyPath];
    if (![currentAttributes isKindOfClass:[NSDictionary class]])
    {
        return;
    }
    
    NSMutableDictionary *mutableCurrentAttributes = [currentAttributes mutableCopy];
    [mutableCurrentAttributes addEntriesFromDictionary:dictionary];
    [self.markdownAttributes setValue:mutableCurrentAttributes forKeyPath:keyPath];
    
    [self renderMarkdown];
}

- (void)renderMarkdown
{
    if (!self.markdownString)
    {
        return;
    }
    
    CMDocument *document = [[CMDocument alloc] initWithData:[self.markdownString dataUsingEncoding:NSUTF8StringEncoding] options:0];
    CMAttributedStringRenderer *renderer = [[CMAttributedStringRenderer alloc] initWithDocument:document attributes:self.markdownAttributes];
    [self.textStorage.mutableString setString:@""];
    [self.textStorage appendAttributedString:[renderer render]];
}

@end
