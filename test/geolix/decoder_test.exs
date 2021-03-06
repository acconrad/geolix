defmodule Geolix.DecoderTest do
  use ExUnit.Case, async: true
  use Bitwise

  test "decoded values" do
    decoded = Geolix.lookup("1.1.1.0", where: :fixture_decoder)

    assert decoded[:utf8_string] == "unicode! ☯ - ♫"
    assert decoded[:double]      == 42.123456
    assert decoded[:bytes]       == <<0, 0, 0, 42>>
    assert decoded[:uint16]      == 100
    assert decoded[:uint32]      == :math.pow(2, 28)
    assert decoded[:int32]       == -1 * :math.pow(2, 28)
    assert decoded[:uint64]      == 1 <<< 60
    assert decoded[:uint128]     == 1 <<< 120
    assert decoded[:array]       == [ 1, 2, 3 ]
    assert decoded[:map]         == %{ mapX: %{ arrayX:       [ 7, 8, 9 ],
                                                utf8_stringX: "hello" }}
    assert decoded[:boolean]     == true
    assert decoded[:float]       == 1.1
  end

  test "empty decoded values" do
    decoded = Geolix.lookup("0.0.0.0", where: :fixture_decoder)

    assert decoded[:utf8_string] == ""
    assert decoded[:double]      == 0.0
    assert decoded[:bytes]       == ""
    assert decoded[:uint16]      == 0
    assert decoded[:uint32]      == 0
    assert decoded[:int32]       == 0
    assert decoded[:uint64]      == 0
    assert decoded[:uint128]     == 0
    assert decoded[:array]       == []
    assert decoded[:map]         == %{}
    assert decoded[:boolean]     == false
    assert decoded[:float]       == 0.0
  end
end
