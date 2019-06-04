


//
//  AllLessonListCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/14.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "AllLessonListCell.h"
#import "ThirdLibsHeader.h"

@implementation AllLessonListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _img = [[UIImageView alloc]initWithFrame:self.contentView.frame];
        _img.image = [UIImage imageNamed:@"testEduLogo"];
        [self.contentView addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
       
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.text = @"为学子提供优质的教育服务和流畅的学费分期";
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(17);
            make.left.equalTo(self.img.mas_right).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-17);
        }];
        
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.numberOfLines = 0;
        _addressLabel.preferredMaxLayoutWidth = xScreenWidth - 200;
        _addressLabel.text = @"上海市徐汇区田林路487号宝石园20号楼708-709室";
        [self.contentView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
            make.left.equalTo(self.titleLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-50);
        }];
        
        for (int i = 0; i<5; i++) {
            
            
           UILabel *kindLabel = [[UILabel alloc]init];
            kindLabel.textColor = [UIColor colorWithHexString:@"#f44640"];
            kindLabel.font = [UIFont systemFontOfSize:10];
            kindLabel.layer.borderWidth = 0.5;
            kindLabel.layer.borderColor = [[UIColor colorWithHexString:@"#f44640"] CGColor];
            kindLabel.text = @"学历";
            kindLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:kindLabel];
            kindLabel.tag = i+300;
            //kindLabel.hidden = YES;
            [kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self.addressLabel.mas_bottom).offset(12);
                make.left.equalTo(self.addressLabel.mas_left).offset(i*57);
            }];
        }
        
        
        
    }
    
    return self;
}

@end
