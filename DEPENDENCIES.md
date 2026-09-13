# Dependencies

No specific Matlab version is recorded. `curveKymograph.m` uses
`imshow` and `getline`, which require Matlab's **Image Processing
Toolbox**. `spline`, `imread`, and `uigetfile` are core Matlab.

## Input/output

`curveKymograph.m` prompts interactively for its input image sequence
via `uigetfile` and for the curve via on-image point selection
(`getline`); it does not require a hardcoded image path to run. The
function signature accepts an optional `path` argument, but the
default value assigned to it when called with no arguments (an
absolute path to the original author's machine) is flagged with a
`% EDIT:` comment -- update it if you choose to call the function
programmatically with a `path` argument instead of using the
interactive prompt.
