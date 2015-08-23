//
//  GCPageView.h
//  GCPagerExtension
//
//  Created by njgarychow on 1/13/15.
//  Copyright (c) 2015 njgarychow. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GCPageMode) {
    GCPageModeDefault,
    GCPageModeInfinite,
};

@class GCPageViewCell;

/**
 *  The GCPageView defines a view scroll horizontally. It shows |GCPageViewCell| one by one. 
 *  It's methods designed like UITableView.
 */
@interface GCPageView : UIView

/**
 *  The initialize method. You must invoke this method to init GCPageView.
 *
 *  @param mode     GCPageViewMode.
 *
 *  @return     An instance for the class GCPageView.
 */
- (instancetype)initWithMode:(GCPageMode)mode;

/**
 *  Required. You must set the block for PageView's cells count.
 *
 *  @param block    return the PageView's cells count.
 *
 *  @return     The PageView itself.
 */
- (instancetype)withBlockForPageViewCellCount:(NSUInteger (^)(GCPageView* pageView))block;

/**
 *  Required. You must set the block for PageView's cell for every page.
 *
 *  @param block    return the PageView's cell at index.
 *
 *  @return     The PageView itself.
 */
- (instancetype)withBlockForPageViewCell:(GCPageViewCell* (^)(GCPageView* pageView, NSUInteger index))block;

/**
 *  Optional. The block will invoked when PageView is scrolling.
 *
 *  @param block    When the PageView is scrolling, the block will be invoked for the visible cells.
 *                  The cell is shown more when the |position| is more close to 0.
 *                  '+' means the cell is the right one, and '-' is the left one.
 *
 *  @return     The PageView itself.
 */
- (instancetype)withBlockForPageViewCellDidScroll:(void (^)(GCPageView* pageView, GCPageViewCell* cell, CGFloat position))block;

/**
 *  Optional. The block will invoked when PageView stop scrolling.
 *
 *  @param block    When the PageView stop scrolling, the block will be invoked for the visible cell.
 *
 *  @return     The PageView itself.
 */
- (instancetype)withBlockForPageViewCellDidEndDisplay:(void (^)(GCPageView* pageView, NSUInteger index, GCPageViewCell* cell))block;

/**
 *  Optional. When user scroll left while the PageView is at the first index, 
 *  you can do something in |leftBorderAction|. 
 *  If the PageViewMode is GCPageViewModeInfinite, this can't be trigger.
 *
 *  @param leftBorderAction     It's invoked when the user scroll left while the PageView is at the first index.
 *
 *  @return     The PageView itself.
 */
- (instancetype)withLeftBorderAction:(void (^)())leftBorderAction;

/**
 *  Optinoal. When user scroll right while the PageView is at the last index,
 *  you can do something in |rightBorderAction|.
 *  If the PageViewMode is GCPageViewModeInfinite, this can't be trigger.
 *
 *  @param rightBorderAction    It's invoked when the user scroll right while the PageView is at the last index.
 *
 *  @return     The PageView itself.
 */
- (instancetype)withRightBorderAction:(void (^)())rightBorderAction;

/**
 *  Optional. An option for the PageView if the user can scroll more than one page at one time.
 *
 *  @param pagingEnabled    If YES, user can scroll more than one page at one time. Otherwise is NO. Default is NO.
 *
 *  @return     The PageView itself.
 */
- (instancetype)withPagingEnabled:(BOOL)pagingEnabled;

/**
 *  Optional. The maximum zoom scale for every page.
 *
 *  @param maximumZoomScale     The maximum zoom scale. Default is 1.0. It must not less than |minimumZoomScale|.
 *
 *  @return     The PageView itself.
 */
- (instancetype)withMaximumZoomScale:(CGFloat)maximumZoomScale;

/**
 *  Optional. The minimum zoom scale for every page.
 *
 *  @param minimumZoomScale     The minimum zoom scale. Default is 1.0. It mut not greater than |maximumZoomScale|.
 *
 *  @return     The PageView itself.
 */
- (instancetype)withMinimumZoomScale:(CGFloat)minimumZoomScale;

/**
 *  Optional. The bounces of the left and right side. Like a UIScrollView's bounces.
 *
 *  @param bounces  Default is YES.
 *
 *  @return     The PageView itself.
 */
- (instancetype)withBounces:(BOOL)bounces;


/**
 *  Get the current page index.
 *
 *  @return     The current page index.
 */
- (NSUInteger)currentPageIndex;

/**
 *  Regist the GCPageViewCell's class for reuse. Like UITableView's regist cells method.
 *
 *  @param cellClass        Subclass of the GCPageViewCell.
 *  @param cellIdentifier   Reuse identifier string.
 */
- (void)registClass:(Class)cellClass withCellIdentifer:(NSString *)cellIdentifier;
/**
 *  Reuse the registed GCPageViewCell's.
 *
 *  @param cellIdentifier   Reuse identifier string.
 *
 *  @return     The reusable instance of GCPageViewCell or it's subclass.
 */
- (id)dequeueReusableCellWithIdentifer:(NSString *)cellIdentifier;

/**
 *  Reload all the data.
 */
- (void)reloadData;

/**
 *  Scroll the PageView to the index. With or without animation.
 *
 *  @param index        The index will be shown.
 *  @param animation    Scroll with or without animation.
 */
- (void)showPageAtIndex:(NSUInteger)index animation:(BOOL)animation;

/**
 *  PageView will scroll automatic with animation in the interval.
 *  If the PageViewMode is GCPageViewModeDefault, it scrolls to the first page when the last page's next.
 *
 *  @param interval     The scroll's interval using seconds.
 */
- (void)startAutoScrollWithInterval:(NSTimeInterval)interval;
/**
 *  Stop the PageView's auto scrolling.
 */
- (void)stopAutoScroll;

@end
