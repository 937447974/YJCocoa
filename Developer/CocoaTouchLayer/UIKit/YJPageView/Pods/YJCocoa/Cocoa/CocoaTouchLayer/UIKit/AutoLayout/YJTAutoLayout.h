//
//  YJTAutoLayout.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "UIView+YJTViewLayoutConstraintCreation.h"
#import "UIViewController+YJTLayoutSupport.h"

// NSLayoutConstraint的相关扩展和封装,可使用伪代码的方式快速开发AutoLayout
// 使用说明
//
// NSLayoutConstraint(item view1: AnyObject, attribute attr1: NSLayoutAttribute, relatedBy relation: NSLayoutRelation, toItem view2: AnyObject?, attribute attr2: NSLayoutAttribute, multiplier: CGFloat, constant c: CGFloat)
// 公式：view1.attr1 = view2.attr2 * multiplier + constant
//
// 遵循的原则，在UI上，
// 1. trailing的View对应view1，leading的View对应view2
// 2. bottom的View对应View1，top的View对应View2
// 3. above的view对应view1，below的view对应view2
//
// 综上所述，即右下的view放在前面，左上的view放在后面。
// 口诀就是：先右下表后左上底
