def func(&block)
  yield block
end

func() {p("a")}
