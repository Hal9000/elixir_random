The `Random` module is based on Erlang's `rand` module. (See http://erlang.org/doc/man/rand.html ).
This in turn is a newer replacement for Erlang's deprecated `random`.

All functionality of `rand` is preserved here. The primary differences are:

 - The preferred function name is `rand` (although `uniform` and `normal` will still work, for people accustomed to those).
 - `rand` takes a parameter `:normal` for normal-distribution results.
 - The `_s` functions are unnecessary, as state is passed (as needed) by means of an optional parameter.
 - Any function that accepts a state also returns the new state (second item in tuple); other functions simply return a number.
 - A distinction is made between `seed` and `seed3` (the latter of which takes a tuple of three integers rather than a state).
 - The functions `export_seed` and `export_seed_s` are not really needed any longer.
 - The `rand` function can take a range, e.g. `rand(50..60)`.
 - The `Random` module adds `sample` (which takes a second parameter, a number defaulting to 0); this calls `Enum.take_random` which works on any enumerable.
 - The `Random` module adds `shuffle` (which simply calls `Enum.shuffle` and thus can take any enumerable.
 - The PRNG is seeded on module load (default algorithm is `:exsplus` just as with `:rand`); you may of course reseed at any time.

Examples
--------

```
x = Random.rand             # Random number between 0.0 and 1.0

x = Random.rand(:normal)    # Random number in normally-distributed range, -1..1 is one sigma

n = Random.rand(5)          # Random integer between 1 and 5

n = Random.rand(10..20)     # Random integer between 10 and 20

state = Random.seed(:exsplus)               # Use the explus algorithm (default), Xorshift116+, 58 bits, period = 2^116-1

state = Random.seed(:exs64)                 # Use the exs64 algorithm, Xorshift64, 64 bits, period = 2^64-1

state = Random.seed(:exs1024)               # Use the exs1024 algorithm, Xorshift1024, 64 bits, period = 2^1024-1

state = Random.seed3(:exsplus, {1, 2, 3})   # Seed using the three integers 1, 2, 3

state = Random.seed(:exsplus, state)        # Seed using the specified state

x = Random.uniform                          # Same as Random.rand

x = Random.normal                           # Same as Random.rand(:normal)

{x, state} = Random.rand(state)             # Specify state and return number and a new state

{x, state} = Random.rand(:normal, state)    # Specify state and return number (normal distribution) and new state

item = Random.sample(enum)                  # Grab one random item from any enumerable (such as a list)

list = Random.sample(enum, 3)               # Grab 3 random items from any enumerable (such as a list)

list = Random.shuffle(enum)                 # Randomize (shuffle) an enumerable (such as a list)
```


Notes
-----
The `sample` and `shuffle` functions do not have state-sensitive variants.

