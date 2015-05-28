//
//  ViewController.m
//  TableViewAttachment
//
//  Created by yanshu on 15/5/11.
//  Copyright (c) 2015年 yanshu. All rights reserved.
//

#import "ViewController.h"
#import "SpringCollectionViewLayout.h"
NSString *const Identifier = @"cell";
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic) UICollectionView *dataCollectionView;
@property (nonatomic) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SpringCollectionViewLayout *layout = [[SpringCollectionViewLayout alloc] init];
    layout.itemSize = CGSizeMake(90, 60);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    self.dataCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _dataCollectionView.delegate = self;
    _dataCollectionView.dataSource = self;
    _dataCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_dataCollectionView];
    [_dataCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:Identifier];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1000;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
