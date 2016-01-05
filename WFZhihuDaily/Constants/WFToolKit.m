//
//  XPToolKit.m
//  SeekClient
//
//  Created by origin on 14/10/20.
//  Copyright (c) 2014年 Dorigin. All rights reserved.
//

#import "WFToolKit.h"
#import <CommonCrypto/CommonDigest.h>


UIColor *RGBColor(float R,float G,float B,float A){
    
    return [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A];
}

void setExtraCellLineHidden(UITableView *tableView){
    
    UIView *view =[ [UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}