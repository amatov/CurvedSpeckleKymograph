## CurvedSpeckleKymograph

## Quick start

This repository implements a curved-line kymograph extraction function
in Matlab. See [DEPENDENCIES.md](DEPENDENCIES.md) for the Image
Processing Toolbox requirement. `curveKymograph.m` prompts
interactively for its input image sequence and the curve to trace.

## Repository contents

- `curveKymograph.m` -- the main function; extracts an image kymograph
  along a curve selected by clicking points on the image (fit with a
  spline if 3 or more points are chosen), using `getFilenameBody.m`.
- `getFilenameBody.m` -- a filename-parsing helper.
- [`media/`](media/) -- an example kymograph output image.
- **License:** see [LICENSE](LICENSE) -- research/educational use.

## About

Matlab code I wrote to implement a curved line kymograph
My function extracts an image kymograph based on a vertical curve selected by user input
For detailed information, see: https://www.researchgate.net/publication/388842022_Quantitative_Cell_Division_and_Migration_in_Medicine
