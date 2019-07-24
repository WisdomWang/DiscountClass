//
//  LessonDetailThreeCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/15.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "LessonDetailThreeCell.h"
#import "ThirdLibsHeader.h"

@implementation LessonDetailThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sectionIcon"]];
        [self.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(27);
            make.left.mas_equalTo(self.contentView.mas_left).offset(17);
        }];
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.text = @"课程简介";
        headerLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        headerLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:headerLabel];
        [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(img.mas_centerY);
            make.left.equalTo(img.mas_right).offset(8);
        }];
        
        _webView = [[WKWebView alloc]init];
        _webView.scrollView.bounces = false;
        [self.contentView addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_bottom).offset(16);
            make.width.equalTo(self.contentView.mas_width);
            make.height.mas_equalTo(500);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

- (void)setHtmlStr:(NSString *)htmlStr {
    
    [_webView loadHTMLString:htmlStr baseURL:nil];
}

@end
