
ExUnit.start()

defmodule RandomTest do
  use ExUnit.Case
# doctest Random

  test "rand returns a float" do
    assert is_float(Random.rand)
  end

  test "rand(5) returns an integer between 1 and 5" do
    n = Random.rand(5)
    assert is_integer(n)
    assert n >= 1 and n <= 5
  end

  test "rand(6..9) returns an integer between 6 and 9" do
    n = Random.rand(6..9)
    assert is_integer(n)
    assert n >= 6 and n <= 9
  end

  test "uniform distribution is always between 0 and 1" do
    list = for _ <- 1..1000, do: Random.rand
    assert Enum.all?(list, &(&1 > 0.0 and &1 < 1.0))
  end

  test "rand(:normal) sometimes returns negative numbers" do
    list = for _ <- 1..10, do: Random.rand(:normal) 
    assert Enum.any?(list, &(&1 < 0.0))
    assert Enum.any?(list, &(&1 >= -1.0 and &1 <= 1.0))
  end

  test "normal() sometimes returns negative numbers" do
    list = for _ <- 1..10, do: Random.normal
    assert Enum.any?(list, &(&1 < 0.0))
    assert Enum.any?(list, &(&1 >= -1.0 and &1 <= 1.0))
  end

  test "for constant state, rand(...) returns the same value" do
    state = Random.seed
    n1 = Random.rand(10000, state)
    n2 = Random.rand(10000, state)
    assert n1 == n2
  end

  test "state can be passed to rand(n, state)" do
    state = Random.seed
    _ = Random.rand(10000)
    {n2, state2} = Random.rand(10000, state)
    assert is_integer(n2)
    assert state2 != state
  end

  test "state can be passed to rand(n1..n2, state)" do
    state = Random.seed
    {n2, state2} = Random.rand(9..20, state)
    assert n2 >= 9 and n2 <= 20
    assert state2 != state
  end

  test "seed can take a state" do
    state = Random.seed
    state2 = Random.seed(state)
    assert state2 == state
  end

  test "seed3(algo, {n1,n2,n3}) works" do
    state = Random.seed3(:exs1024, {1, 2, 3})
    state2 = Random.seed3(:exs1024, {1, 2, 3})
    assert state2 == state
  end

  test "shuffle works on range" do
    range = 1..5
    list = Random.shuffle(range)
    assert Enum.all?(list, &(&1 >= 1 and &1 <= 10))
  end

  test "shuffle works on list" do
    list = [1, 2, 3, 4, 5]
    list = Random.shuffle(list)
    assert Enum.all?(list, &(&1 >= 1 and &1 <= 10))
  end

  test "sample works on range" do
    range = 6..12
    list = Random.sample(range, 2)
    assert length(list) == 2
    assert Enum.all?(list, &(&1 >= 6 and &1 <= 12))
  end

  test "sample works on list" do
    range = [6, 7, 8, 9, 10, 11, 12]
    list = Random.sample(range, 3)
    assert length(list) == 3
    assert Enum.all?(list, &(&1 >= 6 and &1 <= 12))
  end

  test "sample defaults to n=1" do
    range = [6, 7, 8, 9, 10, 11, 12]
    list = Random.sample(range)
    assert length(list) == 1
    assert Enum.all?(list, &(&1 >= 6 and &1 <= 12))
  end

end
