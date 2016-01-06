//
//  WFAutoLoopView.m
//  WFZhihuDaily
//
//  Created by xiupintech on 16/1/6.
//  Copyright © 2016年 xiupintech. All rights reserved.
//

#import "WFAutoLoopView.h"
#import "WFBannerModel.h"
#import "WFBannerView.h"
#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)

@interface WFAutoLoopView () <UIScrollViewDelegate>
{
    BOOL _isHasBanners;
}
@property (nonatomic, assign) int currentIdx;
@property (nonatomic, assign) int pagesCount;
@property (nonatomic, strong) NSMutableArray *cells;

@property (nonatomic, assign, getter=isDragging) BOOL dragging; // 是否在用手指拖动scrollView

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) UIPageControl *pageControl;

@property (nonatomic, copy) int(^numberOfPagesInAutoLoopView)(WFAutoLoopView *autoLoopView);
@property (nonatomic, copy) UIView *(^autoLoopViewCellForIndex)(int index);
@property (nonatomic, copy) void(^scrollToPageForIndex)(int index);

@end

@implementation WFAutoLoopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addScrollView];
        [self addPageControl];
        // 初始化数据
        _isHasBanners = NO;
        _currentIdx = 0;
        _autoLoopScroll = YES;
        _stretchAnimation = NO;
        _autoLoopScrollInterval = 3;
    }
    return self;
}


- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (_autoLoopScroll) {
        if (_pagesCount > 1) {
            [self autoLoopScrollCell];
        }
    }
}

#pragma mark - Private Methods
#pragma mark add scrollView
- (void)addScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor yellowColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(3 * kScreenWidth, 0);
    [self addSubview:_scrollView];
}

#pragma mark add pageControl
- (void)addPageControl {
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    _pageControl.enabled = NO;
    [self insertSubview:_pageControl aboveSubview:self.scrollView];
}

#pragma mark udpate cells
- (void)updateCells {
    
    int previousIdx = [self getVaildNextPageIdxWithIdx:self.currentIdx - 1];
    int nextIdx = [self getVaildNextPageIdxWithIdx:self.currentIdx + 1];
    if (_cells == nil) {
        _cells = [NSMutableArray array];
    }
    [_cells removeAllObjects];
    
    if (_autoLoopViewCellForIndex) {
        [_cells addObject:self.autoLoopViewCellForIndex(previousIdx)];
        [_cells addObject:self.autoLoopViewCellForIndex(_currentIdx)];
        [_cells addObject:self.autoLoopViewCellForIndex(nextIdx)];
    }
}

#pragma mark 重载cells
- (void)reloadCells {
    
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _pagesCount = self.numberOfPagesInAutoLoopView(self);
    [self updateCells];
    
    for (NSInteger i = 0; i < _cells.count; i ++) {
        WFBannerView *cell = [[WFBannerView alloc] init];
        cell.banner = [_cells[i] banner];
        cell.clickBannerCallBackBlock = [_cells[i] clickBannerCallBackBlock];
        cell.userInteractionEnabled = YES;
        CGRect cellFrame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, _scrollView.frame.size.height);
        cell.frame = cellFrame;
        [_scrollView addSubview:cell];
    }
    _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    _pageControl.currentPage = _currentIdx;
    if (_scrollToPageForIndex) {
        _scrollToPageForIndex(_currentIdx);
    }
    
    if (_banners.count == 1) {
        _scrollView.scrollEnabled = NO;
        _pageControl.hidden = YES;
        _autoLoopScroll = NO;
    }
}

- (void)reloadData {
    [self reloadCells];
}

#pragma mark 传入一个idx来获取下一个正确的idx
- (int)getVaildNextPageIdxWithIdx:(int)idx {
    
    if (idx == -1) {
        return (int)_pagesCount - 1;
    } else if (idx == _pagesCount) {
        return 0;
    } else {
        return idx;
    }
}

#pragma mark 循环滚动的方法
- (void)autoLoopScrollCell {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoLoopScrollCell) object:nil];
    CGPoint newOffset = CGPointMake(CGRectGetWidth(_scrollView.bounds) * 2, _scrollView.contentOffset.y);
    [_scrollView setContentOffset:newOffset animated:YES];
    [self performSelector:@selector(autoLoopScrollCell) withObject:nil afterDelay:_autoLoopScrollInterval];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    if(offsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentIdx = [self getVaildNextPageIdxWithIdx:self.currentIdx + 1];
        [self reloadData];
    }
    if(offsetX <= 0) {
        self.currentIdx = [self getVaildNextPageIdxWithIdx:self.currentIdx - 1];
        [self reloadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.bounds), 0) animated:YES];
}

#pragma mark - Setter //tips：切勿反复调用该setter方法

- (void)setBanners:(NSArray *)banners {
    if (_isHasBanners) {
        return;
    }
    _banners = banners;
    _currentIdx = (int)banners.count  - 1;
    NSMutableArray *cells = [NSMutableArray array];
    [banners enumerateObjectsUsingBlock:^(WFBannerModel *banner, NSUInteger idx, BOOL *stop) {
        WFBannerView *cell = [[WFBannerView alloc] initWithFrame:self.frame];
        cell.banner = banner;
        cell.clickBannerCallBackBlock = ^(WFBannerModel *banner){
            if (_clickAutoLoopCallBackBlock) {
                _clickAutoLoopCallBackBlock(banner);
            }
            
        };
        [cells addObject:cell];
    }];
    
    self.numberOfPagesInAutoLoopView = ^int(WFAutoLoopView *autoLoopView) {
        return (int)cells.count;
    };
    
    self.autoLoopViewCellForIndex = ^UIView *(int index) {
        return cells[index];
    };
    
    [self reloadData];
    _isHasBanners = YES;
}


- (void)setAutoLoopScroll:(BOOL)autoLoopScroll {
    
    _autoLoopScroll = autoLoopScroll;
    if (self.window) {
        if (autoLoopScroll) {
            [self autoLoopScroll];
        } else {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoLoopScrollCell) object:nil];
        }
    }
}

- (void)setNumberOfPagesInAutoLoopView:(int (^)(WFAutoLoopView *))numberOfPagesInAutoLoopView {
    
    _numberOfPagesInAutoLoopView = numberOfPagesInAutoLoopView;
    int count = numberOfPagesInAutoLoopView(self);
    _pageControl.numberOfPages = count;
    CGSize pcSize = [_pageControl sizeForNumberOfPages:count];
    _pageControl.frame = CGRectMake((self.bounds.size.width - pcSize.width) * 0.5, self.bounds.size.height - pcSize.height, pcSize.width, pcSize.height);
}

#pragma mark - Public Methods
- (void)wf_parallaxHeaderViewWithOffset:(CGPoint)offset{
    
    if (_stretchAnimation == NO) {
        return;
    }
    
    CGRect frame = _scrollView.frame;
    if (offset.y > 0) {
        
        frame.origin.y = MAX(offset.y/2, 0);
        _scrollView.frame = frame;
        self.clipsToBounds = YES;
        
    }else{
        CGFloat delta = 0.f;
        CGRect rect = kDefaultHeaderFrame;
        delta = fabs(MIN(0.f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        _scrollView.frame = rect;
        CGPoint newPoint = _scrollView.center;
        newPoint.y += delta;
        self.clipsToBounds = NO;
    }
}
@end
