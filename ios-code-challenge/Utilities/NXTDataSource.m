//
//  NXTDataSource.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/20/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "NXTDataSource.h"
#import "NXTCellForObjectDelegate.h"
#import "NXTBindingDataForObjectDelegate.h"
#import "ios_code_challenge-Swift.h"

@interface NXTDataSource()

@property (nonatomic, strong) NSMutableArray *mutableObjects;
@property (nonatomic, strong) NSMutableArray *mutableFilteredObjects;
    
@end

@implementation NXTDataSource
    
- (instancetype)initWithObjects:(NSArray *)objects
{
    if(self = [super init]) {
        _mutableObjects = [NSMutableArray arrayWithArray:objects];
        _shouldAnimateCells = YES;
    }
    
    return self;
}
    
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[NXTSearchController shared] isActive] ? [self.mutableFilteredObjects count] : ([self.mutableObjects count] == 0 ? 10 : [self.mutableObjects count]);
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.mutableObjects count] != 0) {
        id<NXTCellForObjectDelegate> object = self.mutableObjects[indexPath.row];
        return [object estimatedCellHeightForObjectForTableView:tableView];
    } else {
        return 100.0f;
    }
}
    
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.mutableObjects count] != 0) {
        id<NXTCellForObjectDelegate> object = self.mutableObjects[indexPath.row];
        return [object estimatedCellHeightForObjectForTableView:tableView];
    } else {
        return 100.0f;
    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.shouldAnimateCells) {
        NXTBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NXTBusinessTableViewCell.reuseIdentifier];
        
        if(!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NXTBusinessTableViewCell class])
                                                  owner:nil
                                                options:nil] firstObject];
        }
        
        [self showSkeletonCellWithCell:cell];
        
        return cell;
    } else {
        id<NXTCellForObjectDelegate> object = [[NXTSearchController shared] isActive] ? self.filteredObjects[indexPath.row] : self.mutableObjects[indexPath.row];
        id<NXTBindingDataForObjectDelegate> cell = [object cellForObjectForTableView:tableView];
        
        [cell bindingDataForObject:object];
        [self hideSkeletonCellWithCell:(NXTBusinessTableViewCell *)cell];
        return (UITableViewCell *)cell;
    }
}
    
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(id<NXTBindingDataForObjectDelegate>)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell respondsToSelector:@selector(willDisplayCellForObject:)]) {
        id<NXTCellForObjectDelegate> object = self.mutableObjects[indexPath.row];
        
        [cell willDisplayCellForObject:object];
    }
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = self.mutableObjects[indexPath.row];
    
    if(self.tableViewDidSelectCell) {
        self.tableViewDidSelectCell(object);
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
    
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    id object = self.mutableObjects[indexPath.row];
    
    if(self.tableViewDidSelectAccessoryView) {
        self.tableViewDidSelectAccessoryView(object);
    }
}
    
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.tableViewDidScroll) {
        self.tableViewDidScroll();
    }
}
    
#pragma mark - Getters & Setters
- (void)setObjects:(NSArray *)objects
{
    [self.mutableObjects setArray:objects];
}
    
- (void)appendObjects:(NSArray *)objects
{
    [self.mutableObjects addObjectsFromArray:objects];
    
    if(self.tableViewDidReceiveData) {
        self.tableViewDidReceiveData();
    }
}
    
- (void)insertObject:(id)object atIndex:(NSUInteger)index
{
    [self.mutableObjects insertObject:object atIndex:index];
}
    
- (void)removeAllObjects
{
    [self.mutableObjects removeAllObjects];
    
    if(self.tableViewDidReceiveData) {
        self.tableViewDidReceiveData();
    }
}
    
- (void)removeObject:(id)object
{
    [self.mutableObjects removeObject:object];
}
    
- (NSArray *)objects
{
    return self.mutableObjects;
}

- (void)setFilteredObjects:(NSArray *)objects {
    [self.mutableFilteredObjects setArray:objects];
}

- (NSArray *)filteredObjects
{
    return self.mutableFilteredObjects;
}
    
#pragma mark - Properties
- (NSMutableArray *)mutableObjects
{
    if(_mutableObjects == nil) {
        _mutableObjects = [NSMutableArray array];
    }
    
    return _mutableObjects;
}

- (NSMutableArray *)mutableFilteredObjects
{
    if(_mutableFilteredObjects == nil) {
        _mutableFilteredObjects = [NSMutableArray array];
    }
    
    return _mutableFilteredObjects;
}

@end
