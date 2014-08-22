//
//  JRDRatioView.m
//  DrawingBoard
//
//  Created by Jordan Dobson on 8/21/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDRatioView.h"

@interface JRDRatioView ()
    @property (strong, nonatomic) NSBezierPath    *boxPath;
    @property (strong, nonatomic) NSBezierPath    *spiralPath;
    @property (strong, nonatomic) NSMutableString *splitBoxFrom;
    @property NSPoint *theCenterPoint;
    @property double boxWidth;
    @property double extra;
    @property int depth;
    @property int lMargin;
    @property int bMargin;
    @property float rectMin;
    @property float gBox;


@end

@implementation JRDRatioView

static int depthLimit = 20;

- (void)drawRect:(NSRect)dirtyRect
{
    NSPoint cPoint = NSMakePoint((dirtyRect.size.width/2), (dirtyRect.size.height/2));
    self.theCenterPoint = &(cPoint);

    if(dirtyRect.size.width > dirtyRect.size.height) {
        self.rectMin = dirtyRect.size.height;
    } else {
        self.rectMin = dirtyRect.size.width;
    }

    [super drawRect:dirtyRect];
    [self drawBackground: dirtyRect];
    self.gBox = self.rectMin/1.55;
    self.boxWidth = self.gBox;
    self.depth = 0;

    self.boxPath                  = [NSBezierPath bezierPath];
    self.boxPath.lineWidth        = 1;

    self.spiralPath               = [NSBezierPath bezierPath];
    self.spiralPath.lineWidth     = 1.5;
    self.spiralPath.lineJoinStyle = NSRoundLineJoinStyle;

    self.splitBoxFrom = @"top".mutableCopy;

    // Perform Golden Ratio

    for ( int i = 0; i <= depthLimit; i++) {
        if(i == 0){
            // Setup the First Box
            [self createBox                  ];
            [self createFirstCurve           ];
            [self makeInitialRectFromBox     ];
            [self splitNewRectAndAddCurve:YES];
        }else{
            [self splitNewRectAndAddCurve:NO ];
        }
    }
}

-(void) createBox
{
    [[NSColor grayColor] set];


    // Find the Width of the extra part to make rectangle
    double dx   = ((self.gBox/2)-self.gBox);
    double dy   = (0-self.gBox);
    double diag = sqrt(dx*dx+dy*dy);

    self.extra  = (diag-(self.gBox/2));

    [self.boxPath moveToPoint:*(self.theCenterPoint)];
    [self.boxPath relativeMoveToPoint:NSMakePoint(-(self.gBox+self.extra)/2,-self.gBox/2)];

    // Draw Box
    [self.boxPath relativeLineToPoint:NSMakePoint(   self.gBox  ,   0     )];
    [self.boxPath relativeLineToPoint:NSMakePoint(   0     ,   self.gBox  )];
    [self.boxPath relativeLineToPoint:NSMakePoint( -(self.gBox) ,   0     )];
    [self.boxPath relativeLineToPoint:NSMakePoint(   0     , -(self.gBox) )];
}

-(void) makeInitialRectFromBox {
    [self.boxPath relativeMoveToPoint:NSMakePoint(  self.gBox       , 0    )];
    [self.boxPath relativeLineToPoint:NSMakePoint(  self.extra , 0    )];
    [self.boxPath relativeLineToPoint:NSMakePoint(  0          , self.gBox )];
    [self.boxPath relativeLineToPoint:NSMakePoint( -self.extra , 0    )];
    [self.boxPath stroke];
}

-(void)createFirstCurve {
    [[NSColor redColor] set];
    [self.spiralPath moveToPoint: self.boxPath.currentPoint];
    [self.spiralPath relativeCurveToPoint: NSMakePoint( self.gBox, self.gBox) controlPoint1:NSMakePoint(0, 0) controlPoint2:NSMakePoint(0,self.gBox)];
    [self.spiralPath stroke];
}

-(void)splitNewRectAndAddCurve: (BOOL)firstTime{
    if(self.depth > depthLimit){
        return;
    }
    [[NSColor grayColor] set];
    if([self.splitBoxFrom isEqualToString:@"top"]) {
        if(firstTime){
            [self.boxPath relativeMoveToPoint:NSMakePoint(0, -self.extra)];
            [self.boxPath relativeLineToPoint:NSMakePoint(self.extra,  0)];
        }else{
            double size = self.boxWidth - self.extra;
            [self.boxPath moveToPoint:self.spiralPath.currentPoint];
            [self.boxPath relativeMoveToPoint:NSMakePoint(0, -size)];
            [self.boxPath relativeLineToPoint:NSMakePoint(size,  0)];
            self.extra    = size;
            self.boxWidth = self.boxWidth - size;
        }
        self.splitBoxFrom = @"right".mutableCopy;
    } else if([self.splitBoxFrom isEqualToString:@"bottom"]) {
        double size = self.boxWidth - self.extra;
        [self.boxPath moveToPoint:self.spiralPath.currentPoint];
        [self.boxPath relativeMoveToPoint:NSMakePoint(0, size)];
        [self.boxPath relativeLineToPoint:NSMakePoint(-size, 0)];
        self.extra        = size;
        self.boxWidth     = self.boxWidth - size;
        self.splitBoxFrom = @"left".mutableCopy;

    } else if([self.splitBoxFrom isEqualToString:@"left"]){
        double size = self.boxWidth - self.extra;
        [self.boxPath moveToPoint:self.spiralPath.currentPoint];
        [self.boxPath relativeMoveToPoint:NSMakePoint( size , 0 )];
        [self.boxPath relativeLineToPoint:NSMakePoint( 0   ,  size)];
        self.extra        = size;
        self.boxWidth     = self.boxWidth - size;
        self.splitBoxFrom = @"top".mutableCopy;

    } else if([self.splitBoxFrom isEqualToString:@"right"]){
        double size   = self.boxWidth - self.extra;
        [self.boxPath moveToPoint:self.spiralPath.currentPoint];
        [self.boxPath relativeMoveToPoint:NSMakePoint( -size , -size )];
        [self.boxPath relativeLineToPoint:NSMakePoint( 0   ,  size)];
        self.extra        = size;
        self.boxWidth     = self.boxWidth - size;
        self.splitBoxFrom = @"bottom".mutableCopy;
    }

    [self.boxPath stroke];
    [self curveFromBox];
    self.depth = self.depth+1;
}

-(void)curveFromBox {
    [[NSColor redColor] set];
    if([self.splitBoxFrom isEqualToString:@"top"]) {
        [self.spiralPath relativeCurveToPoint: NSMakePoint(self.extra, self.extra)  controlPoint1:NSMakePoint(0, 0) controlPoint2:NSMakePoint(0,self.extra)];
    } else if([self.splitBoxFrom isEqualToString:@"bottom"]) {
        [self.spiralPath relativeCurveToPoint: NSMakePoint(-self.extra, -self.extra)  controlPoint1:NSMakePoint(0, 0) controlPoint2:NSMakePoint(0,-self.extra)];
    } else if([self.splitBoxFrom isEqualToString:@"left"]){
        [self.spiralPath relativeCurveToPoint: NSMakePoint(-self.extra, self.extra)  controlPoint1:NSMakePoint(0, 0) controlPoint2:NSMakePoint(-self.extra,0)];
    } else if([self.splitBoxFrom isEqualToString:@"right"]){
        [self.spiralPath relativeCurveToPoint: NSMakePoint(self.extra , -self.extra)  controlPoint1:NSMakePoint(0, 0) controlPoint2:NSMakePoint(self.extra,0)];
    }
    [self.spiralPath stroke];
}

- (void)drawBackground:(NSRect)dirtyRect
{
    NSImage *halftone = [NSImage imageNamed: @"texture"];
    [[NSColor colorWithPatternImage: halftone] set];
    [NSBezierPath fillRect: dirtyRect];
    
    NSBezierPath *bgPath = [NSBezierPath bezierPathWithRect:dirtyRect];
    [[NSColor whiteColor] set];
    bgPath.lineWidth = 3;
    [bgPath stroke];
}

@end
