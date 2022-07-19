from multi import MyBase, MyDerived

MyBase.Count = 0
class BasePy(MyBase):
	def __init__(self):
		super(BasePy, self).__init__()
		print("Hi BasePy")
	
	def func1(self):
		pass

class DerivedPy(MyDerived, BasePy):
	#__metaclass__ = Meta

	def __init__(self):
		super(DerivedPy, self).__init__()
		print("Hi DerivedPy")
	
	def func2(self):
		pass

dd = DerivedPy()
print(DerivedPy.mro())
print(DerivedPy.__class__.__mro__)
dd = None
assert(MyBase.Count == 0)
