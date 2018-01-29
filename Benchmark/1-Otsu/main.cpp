#include "opencv2/core.hpp"
#include"opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui.hpp"
#include<iostream>
using namespace cv;
using namespace std;

int main(int argc, char *argv[])
{
    Mat inputImage, outputImage;
    inputImage = imread(argv[2],0);
    outputImage = inputImage.clone();
    if(!inputImage.data)
    {
        cout<<"fail to load image."<<endl;
    }
    
    threshold(inputImage,outputImage,0,255,CV_THRESH_BINARY | CV_THRESH_OTSU); //使用大津法二值化操作，阈值可随便设置
    imwrite(argv[4],outputImage);
    
    return 0;

}
