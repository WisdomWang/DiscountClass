//
//  FindListCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/7.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "FindListCell.h"
#import "ThirdLibsHeader.h"

@implementation FindListCell

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
        
        _picImg = [[UIImageView alloc]init];
        _picImg.image = [UIImage imageNamed:@"placeholderImage"];
        [self.contentView addSubview:_picImg];
        [_picImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-17);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(90);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.picImg.mas_top);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.right.equalTo(self.picImg.mas_left).offset(-20);
        }];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(150);
            make.bottom.equalTo(self.picImg.mas_bottom);
        }];
      
    }
    return self;
}

- (void)setModel:(NewsListModel *)model {
    
    _titleLabel.text = model.title;
    _timeLabel.text = model.releaseTime;
    [_picImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"imgPlaceholder"]];
}


@end
