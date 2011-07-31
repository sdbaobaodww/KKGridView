//
//  KKIndexPath.m
//  KKGridView
//
//  Created by Kolin Krewinkel on 7.25.11.
//  Copyright 2011 Giulio Petek, Jonathan Sterling, and Kolin Krewinkel. All rights reserved.
//

#import "KKIndexPath.h"

@implementation KKIndexPath

@synthesize index = _index;
@synthesize section = _section;

- (id)initWithIndex:(NSUInteger)index section:(NSUInteger)section
{
    if ((self = [super init])) {
        _index = index;
        _section = section;
    }
    
    return self;
}

- (NSComparisonResult)compare:(id)object
{
    KKIndexPath *indexPath = (KKIndexPath *)object;
    if (self.index == indexPath.index && self.section == indexPath.section) {
        return NSOrderedSame;
    }
    
    if (indexPath.section > self.section) {
        return NSOrderedDescending;
    } else {
        return NSOrderedAscending;
    }
    
    if (indexPath.section == self.section && indexPath.index > self.index) {
        return NSOrderedDescending;
    } else if (indexPath.section == self.section && indexPath.index < self.index) {
        return NSOrderedAscending;
    }
}

+ (id)indexPathForIndex:(NSUInteger)index inSection:(NSUInteger)section
{
    id retVal = [[[self class] alloc] initWithIndex:index section:section];
#ifndef KK_ARC_ON
    [retVal autorelease];
#endif
    return retVal;
}

- (id)initWithNSIndexPath:(NSIndexPath *)indexPath 
{
    if ((self = [super init])) {
        self.index = indexPath.row;
        self.section = indexPath.section;
    }
    
    return self;
}

+ (id)indexPathWithNSIndexPath:(NSIndexPath *)indexPath 
{
    id retVal = [[[self class] alloc] initWithNSIndexPath:indexPath];
#ifndef KK_ARC_ON
    [retVal autorelease];
#endif
    return retVal;
}

- (BOOL)isEqual:(id)object
{
    KKIndexPath *indexPath = (KKIndexPath *)object;
    if (indexPath.index == self.index && indexPath.section == self.section) {
        return YES;
    }
    
    return NO;
}

- (NSUInteger)hash {
    return _section + 7 * _index;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    id new = [[[self class] alloc] initWithIndex:_index section:_section];
    return new;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Index: %i; Section: %i", _index, _section];
}

@end
