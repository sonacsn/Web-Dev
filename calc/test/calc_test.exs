defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "3 + 2" do
    assert Calc.eval("3 + 2") == 5
  end

  test "(40 + 20)" do
    assert Calc.eval("(40 + 20)") == 60
  end

  test "((40*30)/10+(80*3/3)) " do
    assert Calc.eval("((40*30)/10+(80*3/3))") == 200
  end

  test "check is_digit?" do
    assert Calc.is_digit?("3") == true
    assert Calc.is_digit?(")") == false
    assert Calc.is_digit?("*") == false
  end

  test "test get_number" do
    assert Calc.get_number(["1","3","2"]) == 132
    assert Calc.get_number(["2","4"]) == 24
  end

  test "test operation" do
    assert Calc.operation(30, "-", 10) == 20
    assert Calc.operation(3, "+", 10) == 13
    assert Calc.operation(43, "/", 10) == 4
    assert Calc.operation(50, "*", 110) == 5500
  end

  test "test postfix expressions" do
    input1 = ["(","(","30","*","2",")","-","2",")"]
    input2 = ["30","+","(","4","-","2",")","*","3"]
    input3 = ["10", "*", "50", "+", "20", "/", "3"]

    state1 = %{ops: [], p: [], input: input1}
    state2 = %{ops: [], p: [], input: input2}
    state3 = %{ops: [], p: [], input: input3}

    assert Calc.get_postfix(state1, []) == %{input: [], ops: [], p: [30, 2, "*", 2, "-"]}
    assert Calc.get_postfix(state2, []) == %{input: [], ops: [], p: [30, 4, 2, "-", 3, "*", "+"]}
    assert Calc.get_postfix(state3, []) == %{input: [], ops: [], p: [10, 50, "*", 20, 3, "/", "+"]}
  end

  test "test evaluate_postfix" do
    state1 =  %{stack: [], pexp: [30, 2, "*", 2, "-"]}
    state2 =  %{stack: [], pexp: [30, 4, 2, "-", 3, "*", "+"]}
    state3 =  %{stack: [], pexp: [10, 50, "*", 20, 3, "/", "+"]}

    assert Calc.evaluate_postfix(state1) == 58
    assert Calc.evaluate_postfix(state2) == 36
    assert Calc.evaluate_postfix(state3) == 506
  end
end
