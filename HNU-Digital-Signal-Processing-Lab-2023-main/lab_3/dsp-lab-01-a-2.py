# encoding utf-8
# python 3.10

import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt

# Given specification
Fs = 100000  # Sampling frequency in Hz
fp = 10000  # Pass band frequency in Hz
fs = 16000  # Stop band frequency in Hz
Ap = 1  # Pass band ripple in dB
As = 20  # stop band attenuation in dB

# Compute order of the Chebyshev type-1 filter using signal.cheb1ord
N, wc = signal.cheb1ord(2 * np.pi * fp / Fs, 2 * np.pi * fs / Fs, Ap, As)

# Design the Chebyshev type-1 filter using signal.cheby1
b, a = signal.cheby1(N, Ap, wc, 'low', analog=True)

# Compute frequency response of the filter using signal.freqs function
w, h = signal.freqs(b, a)

# Calculate Magnitude from h in dB
Mag = 20 * np.log10(abs(h))

# Calculate phase angle in degree from h
Phase = np.unwrap(np.arctan2(np.imag(h), np.real(h))) * (180 / np.pi)

# Calculate frequency in Hz from w
Freq = w / (2 * np.pi)

# Plot filter magnitude and phase responses using subplot.
fig = plt.figure(figsize=(10, 6))

# Plot Magnitude response
sub1 = plt.subplot(2, 1, 1)
sub1.plot(Freq, Mag, 'r', linewidth=2)
# sub1.axis([0, Fs / 2, -100, 5])
sub1.set_title('Magnitude Response')
sub1.set_xlabel('Frequency [Hz]')
sub1.set_ylabel('Magnitude [dB]')
sub1.grid()

# Plot phase angle
sub2 = plt.subplot(2, 1, 2)
sub2.plot(Freq, Phase, 'g', linewidth=2)
sub2.set_ylabel('Phase (degree)')
sub2.set_xlabel(r'Frequency (Hz)')
sub2.set_title(r'Phase response')
sub2.grid()

plt.subplots_adjust(hspace=0.5)
fig.tight_layout()
plt.show()
