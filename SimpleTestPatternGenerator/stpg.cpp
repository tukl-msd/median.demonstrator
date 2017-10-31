#include <systemc.h>
#include <hls_stream.h>

typedef struct sc_axis{
    sc_uint<24>       data;
    sc_uint<1>       user;
    sc_uint<1>       last;
  };

void stpg(hls::stream<sc_axis> &stream_out, sc_uint<12> width, sc_uint<12> height)
{
#pragma HLS INTERFACE s_axilite port=return
#pragma HLS INTERFACE s_axilite port=width
#pragma HLS INTERFACE s_axilite port=height
#pragma HLS INTERFACE axis register port=stream_out

	sc_axis pixel;
	sc_uint<8> color = 0;

	pixel.user = 1; // Start of frame

	for(unsigned x = 0; x < height; x++)
	{
		for(unsigned y = 1; y <= width; y++)
		{
			if(y == width) // Last pixel of line
				pixel.last = 1;
			else
				pixel.last = 0;

			pixel.data = color++;

			stream_out.write(pixel);

			pixel.user = 0; // No Start of frame
		}
	}
}
