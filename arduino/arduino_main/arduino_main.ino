#define MAX_PEAKS 8
#define PEAK_MIN_THRESHOLD 0 //! add if things get noisy!

//---------------------------------------------------------------------------//
// Global Variables
int in[128];
byte NoteV[13] = {8, 23, 40, 57, 76, 96, 116, 138, 162, 187, 213, 241, 255};
float f_peak_freqs[MAX_PEAKS]; // Top 8 frequency peaks in descending order
float f_peak_amps[MAX_PEAKS];

//---------------------------------------------------------------------------//

void setup() {
    Serial.begin(115200);
}

void loop() {
    detect_peaks();
}

//----------------------------- Chord Detection Function ----------------------------------------------//
// Documentation: https://www.instructables.com/member/abhilash_patel/instructables/
// Code Written By: Abhilash Patel
// Contact: abhilashpatel121@gmail.com
// This code is written for Arduino Nano (should also work for UNO or better boards).
// It requires at least 2KB of RAM. For more accurate detection, increase the sample size on more powerful boards.

void detect_peaks() {
    unsigned long start_time, end_time;
    float sample, sum_avg = 0, sum_rms = 0, sampling_rate;
    char incoming_byte;

    start_time = micros();
    for (int i = 0; i < 128; i++) {
        sample = analogRead(A0) - 500; // Rough zero shift
        sum_avg += sample;            // Average value
        sum_rms += sample * sample;   // RMS value

        // Apply Hann window
        sample *= pow(sin(i * 3.14 / 128), 2);
        in[i] = 4 * sample;           // Scale for float-to-int conversion

        delayMicroseconds(195);       // Based on operation frequency range
    }
    end_time = micros();

    sum_avg /= 128;                   // Average amplitude
    sum_rms = sqrt(sum_rms / 128);    // RMS amplitude
    sampling_rate = 128000000.0 / (end_time - start_time); // Real-time sampling frequency

    // Start FFT only if amplitude threshold is met
    if (sum_rms - sum_avg > 3) {
        FFT(128, sampling_rate);

        // Reset input array and print FFT results
        for (int i = 0; i < 12; i++) {
            in[i] = 0;
        }

        // Serial.println("FFT performed, outputs:");
        Serial.print('b');
        for (int i = 0; i < MAX_PEAKS; i++) {
            // Serial.print("\tf_peak_freqs[" + String(i) + "] = " + String(f_peak_freqs[i]));
            // Serial.println("\tf_peak_amps[" + String(i) + "] = " + String(f_peak_amps[i]));
            Serial.print(String(f_peak_freqs[i]));
            Serial.print('f');
            Serial.print(String(f_peak_amps[i]));
            Serial.print('a');
        }
        Serial.print('e');
        Serial.flush(); // Ensure all data is sent before next iteration

        // for (int i = 0; i < 100; i++)
        // {
        //     if (Serial.available())
        //     {
        //         incoming_byte = Serial.read();
        //         if (incoming_byte == 'r') 
        //         {
        //             // Serial.println("FFT performed, outputs:");
        //             Serial.print('b');
        //             for (int i = 0; i < MAX_PEAKS; i++) {
        //                 // Serial.print("\tf_peak_freqs[" + String(i) + "] = " + String(f_peak_freqs[i]));
        //                 // Serial.println("\tf_peak_amps[" + String(i) + "] = " + String(f_peak_amps[i]));
        //                 Serial.print(String(f_peak_freqs[i]));
        //                 Serial.print('f');
        //                 Serial.print(String(f_peak_amps[i]));
        //                 Serial.print('a');
        //             }
        //             Serial.print('e');
        //             Serial.flush(); // Ensure all data is sent before next iteration
        //         }
        //     }
        // }


        
    }
}

//----------------------------- FFT Function ----------------------------------------------//
// Documentation: https://www.instructables.com/member/abhilash_patel/instructables/
// EasyFFT code optimized for 128 sample size to reduce memory consumption.

float FFT(byte N, float Frequency) {
    byte levels[8] = {1, 2, 4, 8, 16, 32, 64, 128};
    int num_levels = 0;

    // Determine the number of levels
    // for (int i = 0; i < 8; i++) {
    //     if (levels[i] <= N) {
    //         num_levels = i;
    //     }
    // }
    num_levels = 7;

    byte in_ps[levels[num_levels]] = {};   // Input for sequencing
    float out_r[levels[num_levels]] = {};  // Real part of transform
    float out_im[levels[num_levels]] = {}; // Imaginary part of transform

    // Bit reversal
    int x = 0;
    for (int b = 0; b < num_levels; b++) {
        int c1 = levels[b];
        int f = levels[num_levels] / (c1 + c1);
        for (int j = 0; j < c1; j++) {
            x++;
            in_ps[x] = in_ps[j] + f;
        }
    }

    // Update input array as per bit-reverse order
    for (int i = 0; i < levels[num_levels]; i++) {
        if (in_ps[i] < N) {
            out_r[i] = in[in_ps[i]];
        } else {
            out_r[i] = in[in_ps[i] - N];
        }
    }

    // Perform FFT
    for (int i = 0; i < num_levels; i++) {
        int i10 = levels[i];
        int i11 = levels[num_levels] / levels[i + 1];
        float e = -6.283 / levels[i + 1];

        for (int j = 0; j < i10; j++) {
            float c = cos(e * j);
            float s = sin(e * j);

            for (int k = 0; k < i11; k++) {
                int n1 = j + k * i10 * 2;
                float tr = c * out_r[n1 + i10] - s * out_im[n1 + i10];
                float ti = s * out_r[n1 + i10] + c * out_im[n1 + i10];

                out_r[n1 + i10] = out_r[n1] - tr;
                out_r[n1] += tr;

                out_im[n1 + i10] = out_im[n1] - ti;
                out_im[n1] += ti;
            }
        }
    }

    // Calculate amplitude and frequency bins
    for (int i = 0; i < levels[num_levels - 1]; i++) {
        out_r[i] = sqrt(out_r[i] * out_r[i] + out_im[i] * out_im[i]);
        out_im[i] = (i * Frequency) / levels[num_levels];
    }

    // Peak detection
    x = 0;
    for (int i = 1; i < levels[num_levels - 1] - 1; i++) {
        if (out_r[i] > out_r[i - 1] && out_r[i] > out_r[i + 1] && out_r[i] > PEAK_MIN_THRESHOLD) {
            in_ps[x++] = i;
        }
    }

    // Sort peaks by magnitude
    // for (int i = 0; i < x - 1; i++) {
    //     for (int j = i + 1; j < x; j++) {
    //         if (out_r[in_ps[i]] < out_r[in_ps[j]]) {
    //             int temp = in_ps[i];
    //             in_ps[i] = in_ps[j];
    //             in_ps[j] = temp;
    //         }
    //     }
    // }

    // Update global peak arrays
    //! reinstitute peak count if there nd up being too many.
    //! music generates less than 20 ?
    for (int i = 0; i < x; i++) {
        f_peak_freqs[i] = (out_im[in_ps[i] - 1] * out_r[in_ps[i] - 1] +
                           out_im[in_ps[i]] * out_r[in_ps[i]] +
                           out_im[in_ps[i] + 1] * out_r[in_ps[i] + 1]) /
                          (out_r[in_ps[i] - 1] + out_r[in_ps[i]] + out_r[in_ps[i] + 1]);
        f_peak_amps[i] = out_r[in_ps[i]];
    }
    // Serial.print("*************");
    // Serial.print(x);
    // Serial.print("peaks in this set!!!!*******************");
}