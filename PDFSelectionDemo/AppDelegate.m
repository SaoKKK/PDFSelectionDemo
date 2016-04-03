//
//  AppDelegate.m
//  PDFSelectionDemo
//
//  Created by 河野 さおり on 2016/04/03.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate{
    IBOutlet PDFView *_pdfView;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_pdfView setAllowsDragging:YES];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
}

- (IBAction)getInfo:(id)sender{
    PDFSelection *sel = _pdfView.currentSelection;
    [self selectionLog:sel];
}

- (void)selectionLog:(PDFSelection*)sel{
    NSLog(@"page:%@",sel.pages);
    NSLog(@"string:%@",sel.string);
    NSLog(@"aString:%@",sel.attributedString);
    PDFPage *page = [sel.pages objectAtIndex:0];
    NSRect rect = [sel boundsForPage:page];
    NSLog(@"boundsForPage:(%f,%f,%f,%f)",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    NSLog(@"line:%@",sel.selectionsByLine);
}

- (IBAction)docSelFromChrToChr:(id)sender {
    PDFDocument *doc = _pdfView.document;
    PDFPage *page = _pdfView.currentPage;
    PDFSelection *sel = [doc selectionFromPage:page atCharacterIndex:0 toPage:page atCharacterIndex:100];
    [_pdfView setCurrentSelection:sel];
}

- (IBAction)docSelFromPToP:(id)sender {
    PDFDocument *doc = _pdfView.document;
    PDFPage *page = _pdfView.currentPage;
    PDFSelection *sel = [doc selectionFromPage:page atPoint:NSMakePoint(0, 0) toPage:page atPoint:NSMakePoint(200, 200)];
    [_pdfView goToSelection:sel];
    [_pdfView setCurrentSelection:sel];
}

- (IBAction)docSelAll:(id)sender {
    PDFDocument *doc = _pdfView.document;
    PDFSelection *sel = [doc selectionForEntireDocument];
    [_pdfView setCurrentSelection:sel];
}

- (IBAction)changeColor:(id)sender{
    PDFSelection *sel = _pdfView.currentSelection;
    [sel setColor:[NSColor yellowColor]];
    [_pdfView setNeedsDisplay:YES];
}

- (IBAction)SelectForRect:(id)sender {
    PDFPage *page = _pdfView.currentPage;
    PDFSelection *sel = [page selectionForRect:NSMakeRect(0, 0, 200, 150)];
    [_pdfView setCurrentSelection:sel animate:YES];
}

- (IBAction)selectWortAtPoint:(id)sender {
    PDFPage *page = _pdfView.currentPage;
    PDFSelection *sel = [page selectionForWordAtPoint:NSMakePoint(100, 100)];
    [_pdfView setCurrentSelection:sel animate:YES];
}

- (IBAction)SelectLineAtPoint:(id)sender {
    PDFPage *page = _pdfView.currentPage;
    PDFSelection *sel = [page selectionForLineAtPoint:NSMakePoint(100, 100)];
    [_pdfView setCurrentSelection:sel animate:YES];
}

- (IBAction)selectByRange:(id)sender {
    PDFPage *page = _pdfView.currentPage;
    PDFSelection *sel = [page selectionForRange:NSMakeRange(200, 100)];
    [_pdfView setCurrentSelection:sel animate:YES];
}

- (IBAction)selectPtoP:(id)sender {
    PDFPage *page = _pdfView.currentPage;
    PDFSelection *sel = [page selectionFromPoint:NSMakePoint(100, 100) toPoint:NSMakePoint(300, 300)];
    [sel setColor:[NSColor yellowColor]];
    [_pdfView setHighlightedSelections:[NSArray arrayWithObjects:sel, nil]];
}

- (IBAction)viewSelectAll:(id)sender {
    [_pdfView selectAll:nil];
}

- (IBAction)deselect:(id)sender {
    [_pdfView clearSelection];
}

- (IBAction)viewCopy:(id)sender {
    [_pdfView copy:nil];
}

- (IBAction)GetHilightedSelection:(id)sender {
    NSLog (@"%@",[_pdfView highlightedSelections]);
}

- (IBAction)DelHilite:(id)sender {
    [_pdfView setHighlightedSelections:nil];
    [_pdfView setNeedsDisplay:YES];
}

@end
