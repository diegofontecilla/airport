class StormGenerator

  def is_stormy?
    Kernel.rand(1..4) < 2
  end
end
