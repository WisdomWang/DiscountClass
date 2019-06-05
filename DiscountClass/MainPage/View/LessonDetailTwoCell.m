

//
//  LessonDetailTwoCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/15.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "LessonDetailTwoCell.h"
#import "ThirdLibsHeader.h"

@implementation LessonDetailTwoCell

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
        
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor colorWithHexString:@"#999999"];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(20);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(30);
        }];
        
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label.mas_top);
            make.left.equalTo(self.label.mas_right).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        }];
    }
    return self;
}

@end
