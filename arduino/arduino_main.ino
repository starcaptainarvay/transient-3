//---------------------------------------------------------------------------//
int  in[128];
byte NoteV[13]={8,23,40,57,76,96,116,138,162,187,213,241,255};
float  f_peaks[8]; // top 8 frequencies peaks in descending order
//---------------------------------------------------------------------------//


void  setup() {
Serial.begin(250000);
}


void loop() 
{ 
  Chord_det();

}


//-----------------------------Chord  Detection Function----------------------------------------------//
// Documentation  on Chord_detection:https://www.instructables.com/member/abhilash_patel/instructables/
//  Code Written By: Abhilash Patel
// Contact: abhilashpatel121@gmail.com
//  this code written for arduino Nano board (should also  work for UNO) or better board
//  this code won't work for any board having RAM less than 2kb,
// More accurate  detection can be carried out on more powerful borad by increasing sample size



void  Chord_det()
{ 
  long unsigned int a1,b,a2;
  float a;
  float sum1=0,sum2=0;
  float sampling;
  a1=micros();
        for(int i=0;i<128;i++)
          {
            a=analogRead(A7)-500;     //rough zero shift
            //utilising  time between two sample for windowing & amplitude calculation
            sum1=sum1+a;              //to average value
            sum2=sum2+a*a;            // to  RMS value
            a=a*(sin(i*3.14/128)*sin(i*3.14/128));   // Hann window
            in[i]=4*a;                // scaling for float to int conversion
            delayMicroseconds(195);   // based on operation frequency range
          }
b=micros(); 
sum1=sum1/128;               //average amplitude
sum2=sqrt(sum2/128);         //RMS amplitude
sampling= 128000000/(b-a1);  // real time sampling frequency

//for  very low or no amplitude, this code wont start
//it takes very small aplitude  of sound to initiate for value sum2-sum1>3, 
//change sum2-sum1 threshold based  on requirement
if(sum2-sum1>3){   
       FFT(128,sampling);        //EasyFFT  based optimised  FFT code
        
             
              for(int  i=0;i<12;i++){in[i]=0;}

int j=0,k=0; //below loop will convert frequency  value to note 
       for(int i=0; i<8;i++)
           {
           if(f_peaks[i]>1040){f_peaks[i]=0;}
           if(f_peaks[i]>=65.4   && f_peaks[i]<=130.8) {f_peaks[i]=255*((f_peaks[i]/65.4)-1);}
           if(f_peaks[i]>=130.8  && f_peaks[i]<=261.6) {f_peaks[i]=255*((f_peaks[i]/130.8)-1);}
           if(f_peaks[i]>=261.6  && f_peaks[i]<=523.25){f_peaks[i]=255*((f_peaks[i]/261.6)-1);}
           if(f_peaks[i]>=523.25 && f_peaks[i]<=1046)  {f_peaks[i]=255*((f_peaks[i]/523.25)-1);}
           if(f_peaks[i]>=1046 && f_peaks[i]<=2093)  {f_peaks[i]=255*((f_peaks[i]/1046)-1);}
           if(f_peaks[i]>255){f_peaks[i]=254;}
           j=1;k=0;
         while(j==1)
              {
              if(f_peaks[i]<=NoteV[k]){f_peaks[i]=k;j=0;}
              k++;  // a note with max peaks (harmonic) with aplitude priority is  selected
              if(k>15){j=0;}
              }

              if(f_peaks[i]==12){f_peaks[i]=0;}
              k=f_peaks[i];
              in[k]=in[k]+(8-i);
             }

k=0;j=0;
          for(int i=0;i<12;i++)
             {
              if(k<in[i]){k=in[i];j=i;}  //Max value detection
             }

          for(int i=0;i<8;i++)
             {
              in[12+i]=in[i];
             }        

for  (int i=0;i<12;i++)
{
  in[20+i]=in[i]*in[i+4]*in[i+7];
  in[32+i]=in[i]*in[i+3]*in[i+7];   //all chord check
}


for (int i=0;i<24;i++)
{
in[i]=in[i+20];
if(k<in[i]){k=in[i];j=i;}   // picking chord with max possiblity
}
char chord_out;
int chord=j;
if(chord>11){chord=chord-12;chord_out='m';}  //Mojor-minor check
else{chord_out=' ';}

// Here "chord" variable has  value of detected chord,
// 0-11 defines all majot chord from C,C#,D,D#,.. B
//12-23  defines all minor chord from Cm,C#m,Dm,D#m,.. Bm

  
   a2=micros();
        k=chord;
        if(k==0){Serial.print('C');Serial.println(chord_out);}
        if(k==1){Serial.print('C');Serial.print('#');Serial.println(chord_out);}
        if(k==2){Serial.print('D');Serial.println(chord_out);}
        if(k==3){Serial.print('D');Serial.print('#');Serial.println(chord_out);}
        if(k==4){Serial.print('E');Serial.println(chord_out);}
        if(k==5){Serial.print('F');Serial.println(chord_out);}
        if(k==6){Serial.print('F');Serial.print('#');Serial.println(chord_out);}
        if(k==7){Serial.print('G');Serial.println(chord_out);}
        if(k==8){Serial.print('G');Serial.print('#');Serial.println(chord_out);}
        if(k==9){Serial.print('A');Serial.println(chord_out);}
        if(k==10){Serial.print('A');Serial.print('#');Serial.println(chord_out);}
        if(k==11){Serial.print('B');Serial.println(chord_out);}
       }
       
}

//-----------------------------FFT Function----------------------------------------------//
//  Documentation on EasyFFT:https://www.instructables.com/member/abhilash_patel/instructables/
//  EasyFFT code optimised for 128 sample size to reduce mamory consumtion

float  FFT(byte N,float Frequency)
{
byte data[8]={1,2,4,8,16,32,64,128};
int  a,c1,f,o,x;
a=N;  
                                 
      for(int i=0;i<8;i++)                 //calculating the levels
         { if(data[i]<=a){o=i;} }
      o=7;
byte in_ps[data[o]]={};     //input for sequencing
float out_r[data[o]]={};   //real part of transform
float out_im[data[o]]={};  //imaginory part of transform
           
x=0;  
      for(int b=0;b<o;b++)                     // bit reversal
         {
          c1=data[b];
          f=data[o]/(c1+c1);
                for(int  j=0;j<c1;j++)
                    { 
                     x=x+1;
                     in_ps[x]=in_ps[j]+f;
                    }
         }
 
      for(int i=0;i<data[o];i++)            //  update input array as per bit reverse order
         {
          if(in_ps[i]<a)
          {out_r[i]=in[in_ps[i]];}
          if(in_ps[i]>a)
          {out_r[i]=in[in_ps[i]-a];}      
         }


int i10,i11,n1;
float e,c,s,tr,ti;

    for(int  i=0;i<o;i++)                                    //fft
    {
     i10=data[i];              // overall values of sine cosine  
     i11=data[o]/data[i+1];    // loop with similar sine cosine
     e=6.283/data[i+1];
     e=0-e;
     n1=0;

          for(int j=0;j<i10;j++)
          {
          c=cos(e*j);  
          s=sin(e*j); 
          n1=j;
          
                for(int  k=0;k<i11;k++)
                 {
                 tr=c*out_r[i10+n1]-s*out_im[i10+n1];
                 ti=s*out_r[i10+n1]+c*out_im[i10+n1];
          
                 out_r[n1+i10]=out_r[n1]-tr;
                 out_r[n1]=out_r[n1]+tr;
          
                 out_im[n1+i10]=out_im[n1]-ti;
                 out_im[n1]=out_im[n1]+ti;          
          
                 n1=n1+i10+i10;
                  }       
             }
     }

/*
for(int i=0;i<data[o];i++)
{
Serial.print(out_r[i]);
Serial.print("\	");                                     // uncomment to print RAW o/p    
Serial.print(out_im[i]);  Serial.println("i");      
}
*/

//---> here onward out_r contains  amplitude and our_in conntains frequency (Hz)
    for(int i=0;i<data[o-1];i++)               // getting amplitude from compex number
        {
         out_r[i]=sqrt((out_r[i]*out_r[i])+(out_im[i]*out_im[i]));  // to  increase the speed delete sqrt
         out_im[i]=(i*Frequency)/data[o];
         /*
         Serial.print(out_im[i],2); Serial.print("Hz");
         Serial.print("\	");                            // uncomment to print freuency bin    
         Serial.println(out_r[i]);  
         */
        }

x=0;       // peak detection
   for(int i=1;i<data[o-1]-1;i++)
      {
      if(out_r[i]>out_r[i-1] && out_r[i]>out_r[i+1]) 
      {in_ps[x]=i;    //in_ps array used for storage of peak number
      x=x+1;}    
      }

s=0;
c=0;
    for(int i=0;i<x;i++)             // re arraange as per magnitude
    {
        for(int j=c;j<x;j++)
        {
            if(out_r[in_ps[i]]<out_r[in_ps[j]])  
                {s=in_ps[i];
                in_ps[i]=in_ps[j];
                in_ps[j]=s;}
        }
    c=c+1;
    }
    
    for(int i=0;i<8;i++)     // updating  f_peak array (global variable)with descending order
    {
     // f_peaks[i]=out_im[in_ps[i]];Serial.println(f_peaks[i]);
     f_peaks[i]=(out_im[in_ps[i]-1]*out_r[in_ps[i]-1]+out_im[in_ps[i]]*out_r[in_ps[i]]+out_im[in_ps[i]+1]*out_r[in_ps[i]+1])
     /(out_r[in_ps[i]-1]+out_r[in_ps[i]]+out_r[in_ps[i]+1]);
     // Serial.println(f_peaks[i]);
    } 
}
    
//------------------------------------------------------------------------------------//