#include <systemc.h>
#include <hls_stream.h>

typedef struct sc_axis{
    sc_uint<24>       data;
    sc_uint<1>       user;
    sc_uint<1>       last;
  };

void HLSFilterTemplate(hls::stream<sc_axis> stream_in, hls::stream<sc_axis> &stream_out)
{
#pragma HLS PIPELINE
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE axis register port=stream_in
#pragma HLS INTERFACE axis register port=stream_out

	sc_axis pixel;
	sc_uint<32> sw;

	stream_in >> pixel;

	sw = (pixel.data >> 16) & 0xFF;
	sw += (pixel.data >> 8) & 0xFF;
	sw += pixel.data & 0xFF;

	sw /= 3;

	pixel.data = sw | (sw << 8) | (sw << 16);

	stream_out << pixel;
}
