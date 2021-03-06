require 'xni'

module Example
  extend XNI::Extension
  extension 'example'

  # Attach xni_example_foo() as Example.foo
  native :foo, [], :fixnum

  native :array_of_double, [ carray(:double, :out) ], :void
  native :array_of_fixnum, [ carray(:fixnum, :in) ], :void

  # A DataObject has native memory automatically allocated to hold the fields described by the 'data' directive
  class Foo < XNI::DataObject
    data :m_foo, :fixnum,
         :m_bar, :fixnum
    
    data_reader :m_bar
    data_accessor :m_foo

    # Attach example_foo_s_foo as Example::Foo.foo 
    class << self
      native :foo, [ ], :fixnum
    end

    # Attach a native function as Example::Foo#initialize
    native :initialize, [ :fixnum ], :void
    
    # Attach example_foo_foo() as Example::Foo#foo
    native :foo, [], :fixnum
    
    native :pointer, [], :pointer
    
    native :sum_array_of_double, [ carray(:double, :in), :fixnum ], :double
    native :sum_array_of_fixnum, [ carray(:fixnum, :in), :fixnum ], :fixnum
    
    # custom_finalizer indicates that before freeing the backing memory, it should call xni_#{class name}_finalize 
    custom_finalizer
  end
  
  class Bar < XNI::DataObject
    custom_finalizer

    # Attach a native function as Example::Bar#initialize
    native :initialize, [], :void

    # Attach xni_example_foo_foo() as Example::Bar#bar
    native :bar, [], :fixnum    
  end
end


