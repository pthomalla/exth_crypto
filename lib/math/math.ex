defmodule ExCrypto.Math do
  @moduledoc """
  Helpers for basic math functions.
  """

  @doc """
  Simple function to compute modulo function to work on integers of any sign.

  ## Examples

      iex> ExCrypto.Math.mod(5, 2)
      1

      iex> ExCrypto.Math.mod(-5, 1337)
      1332

      iex> ExCrypto.Math.mod(1337 + 5, 1337)
      5

      iex> ExCrypto.Math.mod(0, 1337)
      0
  """
  def mod(x, n) when x > 0, do: rem x, n
  def mod(x, n) when x < 0, do: rem n + x, n
  def mod(0, _n), do: 0

  @doc """
  Simple wrapper function to convert a hex string to a binary.

  ## Examples

      iex> ExCrypto.Math.hex_to_bin("01020a0d")
      <<0x01, 0x02, 0x0a, 0x0d>>
  """
  @spec hex_to_bin(String.t) :: binary()
  def hex_to_bin(hex) do
    {:ok, bin} = Base.decode16(hex, case: :lower)

    bin
  end

  @doc """
  Left pads a given binary to specified length in bytes.

  This function raises if binary longer than given length already.

  ## Examples

      iex> ExCrypto.Math.pad(<<1, 2, 3>>, 6)
      <<0x00, 0x00, 0x00, 0x01, 0x02, 0x03>>

      iex> ExCrypto.Math.pad(<<1, 2, 3>>, 4)
      <<0x00, 0x01, 0x02, 0x03>>

      iex> ExCrypto.Math.pad(<<1, 2, 3>>, 3)
      <<0x01, 0x02, 0x03>>

      iex> ExCrypto.Math.pad(<<1, 2, 3>>, 0)
      ** (ArgumentError) argument error

      iex> ExCrypto.Math.pad(<<>>, 0)
      <<>>
  """
  @spec pad(binary(), integer()) :: binary()
  def pad(bin, length) do
    padding_bits = ( length - byte_size(bin) ) * 8

    <<0x00::size(padding_bits)>> <> bin
  end

  @doc """
  Simple wrapper function to convert a binary to a hex string.

  ## Examples

      iex> ExCrypto.Math.bin_to_hex(<<0x01, 0x02, 0x0a, 0x0d>>)
      "01020a0d"
  """
  @spec bin_to_hex(binary()) :: String.t
  def bin_to_hex(bin), do: Base.encode16(bin, case: :lower)

  @doc """
  Generate a random nonce value of specified length.

  ## Examples

      iex> ExCrypto.Math.nonce(32) |> byte_size
      32

      iex> ExCrypto.Math.nonce(32) == ExCrypto.Math.nonce(32)
      false
  """
  @spec nonce(integer()) :: binary()
  def nonce(nonce_size) do
    :crypto.strong_rand_bytes(nonce_size)
  end

end