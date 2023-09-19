/*
Name: Rahat Bin Taleb
Date: September 17, 2023
Assignment-1 Question-3 
*/


/* 
Intution: To make the program reusable and write any character or digits by drawing 
shapes (polygons) i have choose to make a segment display consists of 14 segments! 
The lighting up of a specific combinations of the segments will give us something 
between range 0-9 or a-z or A-Z or symbols.
Source: https://7seg.fandom.com/wiki/14-segment_display
*/


/* 
We will need a hash map to store the combinations of segments which will generate a specific 
char when lighted up in segment display!
*/
import java.util.HashMap;
import java.util.Map;

/* 
I have designed the program in such a way that the whole program depends upon these 
few variables only ! There are not much varibales even inside the code except this!
So we can use these variables as joystick to customize the font width and sizes.
*/
float l = 75; //length of polygons
float w = 15; // width of ploygons
float p = 85; // starting x of first char in display.
float q = 75; // starting y of first char in display.
Map<Character, String[]> segmentDictionary = new HashMap<>();//lightup logic map


//utility variables
float halfL = (float)(l / 2);
float halfW = (float)(w / 2);
int stretch = 5;

/*
the screen is setupped in such a way that it can accumulate atleast 5 characters.
If needed the display size can be changed.
*/
void setup() {
    size(950,300);
    colorMaker(255,153,51);
    
    /*
    logic dictonary for lighting up segments of segmentDisplay.I have just wrote the 
    the logical triggers for my Given Name Alphabets and an etxra example name only but one can add 
    upp his own segment lighting up logic for any char,digit or symbol.To see all 
    available segments at a time try to call segmentDisplay("*"); 
    */
    segmentDictionary.put('A', new String[]{"l1", "l2","m1", "m2", "r1", "r2","t"});
    segmentDictionary.put('D', new String[]{"b", "t","r1", "r2", "v1", "v2"});
    segmentDictionary.put('H', new String[]{"l1", "l2","m1", "m2", "r1", "r2"});
    segmentDictionary.put('I', new String[]{"t", "b","v1", "v2"});
    segmentDictionary.put('R', new String[]{"t", "m1", "l2", "l1", "sru","srd"});
    segmentDictionary.put('T', new String[]{"t", "v1", "v2","l1","r1"});
    segmentDictionary.put('S', new String[]{"t","l1","m1","m2","r2","b"});
    segmentDictionary.put('V', new String[]{"l1","l2","sld","sru"});
    segmentDictionary.put('*', new String[]{"t", "b", "m1", "m2", "l2", "l1", "r2", "r1", "v1", "v2", "slu", "srd", "sld", "sru"});
    
    segmentDisplay("*"); 
    // segmentDisplay("david"); //extra example
}

/*
these is a simple function that takes some values for the r , g and b and helps to fill 
any kind of shape with any kind of color quickly.
*/
void colorMaker(int r,int g,int b) {
    color c = color(r,g,b);  // Define color 'c'
    fill(c);  // Use color variable 'c' as fill color
    background(96,96,96);
}

// these functions takes pairs of vertices to draw polygons using them.
void constructPolygon(float[][] pairs) {
    beginShape();
    for (int i = 0; i < pairs.length; i++) {
        float x = pairs[i][0];
        float y = pairs[i][1];
        vertex(x, y);
    }
    endShape(CLOSE);
}

/*
to form the 14 segments circuit board we will be required with some shapes and those are 
hexa , penta and stripe.
*/

/*
helps to draw verticle Hexagons focusing on a specific cordinate perspective with 
length and width.
*/
void verticalHexagon(float p3,float p4 , float l , float w) {
    float[][] pairs = {
        {p3, p4} ,
        {p3 - (w / 2), p4 - (w / 2)} ,
        {p3 - (w / 2), p4 - (w / 2) - l} ,
        {p3, p4 - w - l} ,
        {p3 + (w / 2), p4 - (w / 2) - l} ,
        {p3 + (w / 2), p4 - (w / 2)}
        };
    constructPolygon(pairs);
}

/*
helps to draw horizontal Hexagons focusing on a specific cordinate perspective with 
length and width.
*/
void horizontalHexagon(float p1, float p2, float  l , float w) {
    float[][] pairs = {
        {p1, p2} ,
        {p1 + l, p2} ,
        {p1 + l + halfW, p2 - halfW} ,
        {p1 + l, p2 - w} ,
        {p1, p2 - w} ,
        {p1 - halfW, p2 - halfW}
    };
    
    constructPolygon(pairs);
}

/*
helps to draw Pentagons focusing on a specific cordinate perspective with effect for 
rotating it 180 degrees.
*/
void pentagon(float p1, float p2, int effect) {
    float[][] pairs = {
        {p1, p2} ,
        {p1 - halfW , p2 - (stretch * halfW * effect)} ,
        {p1 - halfW , p2 - (halfW + l) * effect} ,
        {p1  + halfW, p2 - (halfW + l) * effect} ,
        {p1  + halfW, p2 - (stretch * halfW * effect)} ,
        };
    constructPolygon(pairs);
}

/*
helps to draw verticle Stripes focusing on a specific cordinate perspective and the horizon
and vertical actually forms 4 stripes in 4 locations just by reusing same formula.
*/
void stripe(float p, float q , int horizon , int vertical) {
    float[][] pairs = {
        {p, q} ,
        {p - (halfW * horizon),q - (halfW * vertical)} ,
        {p - (w + (halfL - w)) * horizon, q - l * vertical} ,
        {p - (w + (halfL - w)) * horizon, q - (l + halfW) * vertical} ,
        {p - (w + (halfL - w) - halfW) * horizon, q - (l + halfW) * vertical} ,
        {p  - halfW * horizon, q - (stretch * halfW) * vertical}
        };
    constructPolygon(pairs);
}


//lights up all the needed segments for making a specific char in circuit board
void lightSwitches(char c) {
    String[] segments = segmentDictionary.get(c);
    for (String segment : segments) {
        lightUp(segment);
    }
}

/*This functions takes any string for showing in the segment display
but the segment display will only able to show it if those char doesn't have the
logic maps ie: (line43)*/
void segmentDisplay(String givenName) {
    for (char c : givenName.toCharArray()) {
        char uppercaseC = Character.toUpperCase(c);
        lightSwitches(uppercaseC);
        p += 2 * (l + w);
    }
}

//this is the most important function that take the segmentName as the case code for 
//lighting up that specific segment of circuit board follwing the logic map(line43).

/*
Besides that  have followed the spider mapping techniques where all the segments are 
generated in relation to just a single point. So these complex formulas are made by 
dynamic graph plotations in desmos.
*/
void lightUp(String segmentName) {
    switch(segmentName) {
        case "t":
            horizontalHexagon(p,q,l,w);
            break;
        case "b":
            horizontalHexagon(p,q + 2 * (l + w),l,w);
            break;
        case "m1":
            horizontalHexagon(p,q + 2 * (l + w) - halfW - (l + w) + halfW,halfL - halfW,w);
            break;   
        case "m2":
            horizontalHexagon(p + w + halfL - halfW,q + 2 * (l + w) - halfW - (l + w) + halfW,halfL - halfW,w);
            break; 
        case "l2":
            verticalHexagon(p - halfW,q + 2 * (l + w) - halfW,l,w);
            break;    
        case "l1":
            verticalHexagon(p - halfW,q + 2 * (l + w) - halfW - (l + w),l,w);
            break; 
        case "r2":
            verticalHexagon(p + l + halfW,q + 2 * (l + w) - halfW,l,w);
            break; 
        case "r1":
            verticalHexagon(p + l + halfW,q + 2 * (l + w) - halfW - (l + w),l,w);
            break; 
        case "v1":
            pentagon(p + halfL,q + 2 * (l + w) - halfW - (l + w),1);
            break; 
        case "v2":
            pentagon(p + halfL,q + 2 * (l + w) - halfW - (l + w), - 1);
            break; 
        case "slu":
            stripe(p + halfL,q + l + halfW,1,1);
            break; 
        case "srd":
            stripe(p + halfL,q + l + halfW, - 1, - 1);
            break; 
        case "sld":
            stripe(p + halfL,q + l + halfW,1, - 1);
            break;   
        case "sru":
            stripe(p + halfL,q + l + halfW, - 1,1);
            break;            
    }
}
