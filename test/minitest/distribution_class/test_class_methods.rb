require 'minitest/autorun'
require 'croupier'

class TestDistributionClassClassMethods < MiniTest::Unit::TestCase

  def distribution_subclass_with_name name
    Class.new Croupier::Distribution do
      distribution_name name
    end
  end

  def distribution_subclass_with_description description
    Class.new Croupier::Distribution do
      distribution_description description
    end
  end

  def distribution_subclass_with_generator_class klazz
    Class.new Croupier::Distribution do
      generator_class klazz
    end
  end

  def distribution_subclass_with_generator_block &block
    Class.new Croupier::Distribution do
      generator_block &block
    end
  end

  def test_name_setter_adds_the_name
    a = distribution_subclass_with_name "My name"
    assert_equal "My name", a.distribution_name
  end

  def test_name_sets_separated_names_for_each_subclass
    a = distribution_subclass_with_name "A"
    b = distribution_subclass_with_name "B"
    assert_equal "A", a.distribution_name
    assert_equal "B", b.distribution_name
    assert_nil Croupier::Distribution.distribution_name
  end

  def test_description_setter_adds_the_description
    a = distribution_subclass_with_description "My desc"
    assert_equal "My desc", a.distribution_description
  end

  def test_description_sets_separated_descriptions_for_each_subclass
    a = distribution_subclass_with_description "A"
    b = distribution_subclass_with_description "B"
    assert_equal "A", a.distribution_description
    assert_equal "B", b.distribution_description
    assert_nil Croupier::Distribution.distribution_description
  end

  def test_responds_to_generators_methods
    assert_respond_to ::Croupier::Distribution, 'inv_cdf'
    assert_respond_to ::Croupier::Distribution, 'minimum_sample'
    assert_respond_to ::Croupier::Distribution, 'with_enumerator'
  end

  def test_generator_class_setter_adds_generator_class
    klazz = Class.new
    a = distribution_subclass_with_generator_class klazz
    assert_equal klazz, a.generator_class
  end

  def test_generator_class_sets_separated_classes_for_each_subclass
    ka = Class.new
    kb = Class.new
    a = distribution_subclass_with_generator_class ka
    b = distribution_subclass_with_generator_class kb
    assert_equal ka, a.generator_class
    assert_equal kb, b.generator_class
    assert_nil Croupier::Distribution.generator_class
  end

  def test_generator_block_setter_adds_generator_class
    block = -> { 2 }
    a = distribution_subclass_with_generator_block &block
    assert_equal block, a.generator_block
  end

  def test_generator_block_sets_separated_blocks_for_each_subclass
    pa = -> { 2 }
    pb = -> { 3 }
    a = distribution_subclass_with_generator_block &pa
    b = distribution_subclass_with_generator_block &pb
    assert_equal pa, a.generator_block
    assert_equal pb, b.generator_block
    assert_nil Croupier::Distribution.generator_block
  end
end