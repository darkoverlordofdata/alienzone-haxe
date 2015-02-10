/**
 *--------------------------------------------------------------------+
 * mt19937.hx
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014
 *--------------------------------------------------------------------+
 *
 * This file is a part of mt19937.hx
 *
 * mt19937.hx is free software; you can copy, modify, and distribute
 * it under the terms of the MIT License
 *
 *--------------------------------------------------------------------+
 *
 */
package alienzone;
/**
   A C-program for MT19937, with initialization improved 2002/1/26.
   Coded by Takuji Nishimura and Makoto Matsumoto.
   Before using, initialize the state by using init_genrand(seed)
   or init_by_array(init_key, key_length).
   Copyright (C) 1997 - 2002, Makoto Matsumoto and Takuji Nishimura,
   All rights reserved.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions
   are met:
     1. Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
     2. Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.
     3. The names of its contributors may not be used to endorse or promote
        products derived from this software without specific prior written
        permission.
   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
   A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
   Any feedback is very welcome.
   http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html
   email: m-mat @ math.sci.hiroshima-u.ac.jp (remove space)
*/


class Mersenne {

    /* Period parameters */
    static var N:Int = 624;
    static var M:Int = 397;
    static var MATRIX_A:Int = 0x9908b0df;       /* constant vector a */
    static var UPPER_MASK:Int = 0x80000000;     /* most significant w-r bits */
    static var LOWER_MASK:Int = 0x7fffffff;     /* least significant r bits */

    var mt:Array<UInt> = [for (i in 0...N) 0];  /* the array for the state vector */
    var mti:Int = N+1;                          /* mti==N+1 means mt[N] is not initialized */


    public function new(?seed:Int, ?seed_array:Array<Int>) {
        
        if (seed == null && seed_array == null) {
            var ms:Float = Date.now().getTime();
            if (ms%1000 == 0) {
                /**
                 * Millisecond precision is not available on all targets
                 * This makes for a predictable sort seed, so...
                 * Copy and invert the next 3 significant digits
                 */
                var a:Int = Std.int(ms/1000);
                var b:Int = 999-a%1000;
                seed = Std.parseInt('$a$b');
            } else {
                seed = Std.int(Date.now().getTime());
            }
        }
        if (seed_array == null) {
            init_genrand(seed);
        } else {
            init_by_array(seed_array, seed_array.length);
        }
    }

    /**
     * Generates a random boolean value.
     */
    public function nextBool():Bool {
        return ((genrand_int32() & 1) == 1);
    }

    /**
     * Generates a random real value from 0.0, inclusive, to 1.0, exclusive.
     */
    public function nextDouble():Float {
        return genrand_res53();
    }

    /**
     * Generates a random int value from 0, inclusive, to max, exclusive.
     */
    public function nextInt(max:Int):Int {
        return Std.int(genrand_res53() * max);
    }
    
    /* initializes mt[N] with a seed */
    public function init_genrand(s:UInt) {
        mt[0] = s & 0xffffffff;
        mti = 1;
        while (mti < N) {
            mt[mti] =
                (1812433253 * (mt[mti-1] ^ (mt[mti-1] >>> 30)) + mti);
            /* See Knuth TAOCP Vol2. 3rd Ed. P.106 for multiplier. */
            /* In the previous versions, MSBs of the seed affect   */
            /* only MSBs of the array mt[].                        */
            /* 2002/01/09 modified by Makoto Matsumoto             */
            mt[mti] &= 0xffffffff;
            /* for >32 bit machines */
            mti++;
        }
    }

    /* initialize by an array with array-length */
    /* init_key is the array for initializing keys */
    /* key_length is its length */
    /* slight change for C++, 2004/2/26 */
    private function init_by_array(init_key:Array<Int>, key_length:Int) {
        var i:Int, j:Int, k:Int;
        init_genrand(19650218);
        i=1;j=0;
        k = (N>key_length ? N : key_length);
        while (k>0) {
            mt[i] = (mt[i] ^ ((mt[i-1] ^ (mt[i-1] >>> 30)) * 1664525))
                + init_key[j] + j; /* non linear */
            mt[i] &= 0xffffffff; /* for WORDSIZE > 32 machines */
            i++; j++;
            if (i>=N) { mt[0] = mt[N-1]; i=1; }
            if (j>=key_length) j=0;
            k--;
        }
        k=N-1;
        while (k>0) {
            mt[i] = (mt[i] ^ ((mt[i-1] ^ (mt[i-1] >>> 30)) * 1566083941))
                - i; /* non linear */
            mt[i] &= 0xffffffff; /* for WORDSIZE > 32 machines */
            i++;
            if (i>=N) { mt[0] = mt[N-1]; i=1; }
            k--;
        }

        mt[0] = 0x80000000; /* MSB is 1; assuring non-zero initial array */
    }
    
    /* generates a random number on [0,0xffffffff]-interval */
    public function genrand_int32():UInt {
        var y:UInt;
        var mag01:Array<UInt> = [0x0, MATRIX_A];

        if (mti >= N) { /* generate N words at one time */
            var kk:UInt;
            
            if (mti == N + 1) /* if init_genrand() has not been called, */
                init_genrand(5489); /* a default initial seed is used */
        
            kk = 0;
            while (kk < N-M) {
                y = (mt[kk] & UPPER_MASK) | (mt[kk + 1] & LOWER_MASK);
                mt[kk] = mt[kk + M] ^ (y >>> 1) ^ mag01[y & 0x1];
                kk++;
            }
            while (kk < N-1) {
                y = (mt[kk] & UPPER_MASK) | (mt[kk + 1] & LOWER_MASK);
                mt[kk] = mt[kk + (M - N)] ^ (y >>> 1) ^ mag01[y & 0x1];
                kk++;
            }
            y = (mt[N - 1] & UPPER_MASK) | (mt[0] & LOWER_MASK);
            mt[N - 1] = mt[M - 1] ^ (y >>> 1) ^ mag01[y & 0x1];

            mti = 0;
        }
        y = mt[mti++]; // enforce 32 bit range
        /* Tempering */
        y ^= (y >>> 11);
        y ^= ((y << 7) & 0x9d2c5680);
        y ^= ((y << 15) & 0xefc60000);
        y ^= (y >>> 18);

        return y >>> 0;
    }

    /* generates a random number on [0,0x7fffffff]-interval */
    public function genrand_int31():Int {
        return (genrand_int32() >>> 1);
    }

    /* generates a random number on [0,1]-real-interval */
    public function genrand_real1():Float {
        return genrand_int32() * (1.0 / 4294967296.0);
        /* divided by 2^32-1 */
    }

    /* generates a random number on [0,1)-real-interval */
    public function genrand_real2():Float {
        return genrand_int32() * (1.0 / 4294967296.0);
        /* divided by 2^32 */
    }

    /* generates a random number on (0,1)-real-interval */
    public function genrand_real3():Float {
        return (genrand_int32() + 0.5) * (1.0 / 4294967296.0);
        /* divided by 2^32 */
    }

    /* generates a random number on [0,1) with 53-bit resolution*/
    public function genrand_res53():Float {
        var a:UInt = genrand_int32() >>> 5, b:UInt = genrand_int32() >>> 6;
        return (a * 67108864.0 + b) * (1.0 / 9007199254740992.0);
    }
}
