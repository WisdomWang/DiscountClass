//
//  MainEduListCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/8.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "MainEduListCell.h"
#import "ThirdLibsHeader.h"
#import "MainEduCollectionViewCell.h"
#import "EduModel.h"

NSString *const xEduCollectionViewCell = @"EduCellCollectionViewCell";

@interface MainEduListCell ()<UICollectionViewDataSource, UICollectionViewDelegate> {
    
    CGFloat cellCollectionViewHeight;
    
}

@end

@implementation MainEduListCell

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
        
         [self initCollectionView];
    }
    return self;
}

- (void)initCollectionView {
    
    CGFloat lineSpacing = 12.0f;
    CGFloat itemSpacing = 16.0f;
    NSUInteger itemhorizontalCount = 3;
    
    CGFloat itemWidth = (xScreenWidth - (itemhorizontalCount+1)*itemSpacing - 1.0)/itemhorizontalCount;
    CGFloat itemHeight = itemWidth *(50.0f/92.0f);
    
    UICollectionViewFlowLayout *cvFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    cvFlowLayout.scrollDirection            = UICollectionViewScrollDirectionVertical;
    cvFlowLayout.sectionInset               = UIEdgeInsetsMake(15, itemSpacing, 0, itemSpacing);
    cvFlowLayout.minimumLineSpacing         = lineSpacing;
    cvFlowLayout.minimumInteritemSpacing    = itemSpacing;
    cvFlowLayout.itemSize                   = CGSizeMake(itemWidth, itemHeight);
    
    _cellCollectionView = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:cvFlowLayout];
    
    _cellCollectionView.backgroundColor   = [UIColor colorWithHexString:@"#f8f8f8"];
    _cellCollectionView.bounces           = NO;
    _cellCollectionView.delegate          = self;
    _cellCollectionView.dataSource        = self;
    
    [_cellCollectionView registerClass:[MainEduCollectionViewCell class] forCellWithReuseIdentifier:xEduCollectionViewCell];
    
    [self.contentView addSubview:_cellCollectionView];
    
    [_cellCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(236);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _eduListArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EduArrModel *m = _eduListArr[indexPath.row];
    MainEduCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:xEduCollectionViewCell forIndexPath:indexPath];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:m.icon]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.EduDetailBlcok(indexPath);
}


@end
