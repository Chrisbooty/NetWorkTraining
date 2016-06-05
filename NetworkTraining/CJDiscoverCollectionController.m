//
//  CJDiscoverCollectionController.m
//  NetworkTraining
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import "CJDiscoverCollectionController.h"
#import "CJTool.h"
#import "CJCollectionViewCell.h"

@interface CJDiscoverCollectionController ()

/** 数据源 */
@property(nonatomic,strong)NSMutableArray *dataArrM;

@end

@implementation CJDiscoverCollectionController

static NSString * const reuseIdentifier = @"Cell";

-(void)viewWillAppear:(BOOL)animated
{
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(NSMutableArray *)dataArrM
{
    if (_dataArrM == nil) {
        _dataArrM = [NSMutableArray array];
        NSArray *arr = [[CJTool sharedTool] searchModelName:@"Model"];
        for (CJModel *model in arr) {
            if (model.collect) {
                [_dataArrM addObject:model];
            }
        }
    }
    return _dataArrM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArrM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    CJModel *model = self.dataArrM[indexPath.row];
    cell.model = model;
    
    return cell;
}

@end
