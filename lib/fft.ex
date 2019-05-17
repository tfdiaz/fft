defmodule Ditfft do
  def fft(list) do
    pad(list)
      |> Enum.map(fn x -> if is_number(x), do: ComplexNum.new(x), else: x end)
      |> fft_calc()
  end

  def fft_calc(list) when length(list) > 2 do
    n = length(list)
    even = Enum.take_every(list, 2) |> fft_calc()
    odd = Enum.drop_every(list, 2) |> fft_calc()

    first_half =
      for i <- 0..(div(n, 2) - 1) do
        ComplexNum.add(
          Enum.at(even, i),
          ComplexNum.mult(create(-2 * Math.pi() / n * i), Enum.at(odd, i))
        )
      end
 
    sec_half =
      for i <- 0..(div(n, 2) - 1) do
        ComplexNum.sub(
          Enum.at(even, i),
          ComplexNum.mult(create(-2 * Math.pi() / n * i), Enum.at(odd, i))
        )
      end

    first_half ++ sec_half
  end

  def fft_calc(list) when length(list) == 2 do
   [
     Enum.reduce(list, fn x, acc -> ComplexNum.add(acc, x) end),
     Enum.reduce(list, fn x, acc -> ComplexNum.sub(acc, x) end)
   ]
  end

  def create(x) do
    ComplexNum.new(Math.cos(x), Math.sin(x))
  end

  def pad(list) do
    use Bitwise
    n = length(list)
    cond do
      (n &&& (n - 1)) == 0 -> list
      true -> pad(list ++ [0])
    end
  end
end
