"""
Test cases for YourResourceModel Model

"""
import os
import logging
import unittest
from service.models import Category, Product, DataValidationError, db
from service import app


DATABASE_URI = os.getenv(
    "DATABASE_URI", "postgresql://postgres:postgres@localhost:5432/testdb"
)


######################################################################
#  Product   M O D E L   T E S T   C A S E S
######################################################################
# pylint: disable=too-many-public-methods
class TestProductModel(unittest.TestCase):
    """Test Cases for Product Model"""

    @classmethod
    def setUpClass(cls):
        """This runs once before the entire test suite"""
        app.config["TESTING"] = True
        app.config["DEBUG"] = False
        app.config["SQLALCHEMY_DATABASE_URI"] = DATABASE_URI
        app.logger.setLevel(logging.CRITICAL)
        Product.init_db(app)

    @classmethod
    def tearDownClass(cls):
        """This runs once after the entire test suite"""
        db.session.close()
        db.drop_all()  # clean up test db

    def setUp(self):
        """This runs before each test"""
        db.session.query(Product).delete()  # clean up the last tests
        db.session.commit()

    def tearDown(self):
        """This runs after each test"""
        db.session.remove()

    ######################################################################
    #  T E S T   C A S E S
    ######################################################################

    def test_create_a_product(self):
        """It should Create a Product and assert that it exists"""
        product = Product(
            name="iPhone 15 Pro",
            description="Titanium. A17 Pro chip",
            price=999,
            available=True,
            category=Category.ELECTRONICS,
        )
        self.assertTrue(product is not None)
        self.assertEqual(product.id, None)
        self.assertEqual(product.name, "iPhone 15 Pro")
        self.assertEqual(product.description, "Titanium. A17 Pro chip")
        self.assertEqual(product.price, 999)
        self.assertEqual(product.available, True)
        self.assertEqual(product.category, Category.ELECTRONICS)

    def test_add_a_product(self):
        """It should Create a product and add it to the database"""
        products = Product.all()
        self.assertEqual(products, [])
        product = Product(
            name="iPhone 15 Pro",
            description="Titanium. A17 Pro chip",
            price=999,
            available=False,
            category=Category.ELECTRONICS,
        )
        self.assertTrue(product is not None)
        self.assertEqual(product.id, None)
        product.create()
        # Assert that it was assigned an id and shows up in the database
        self.assertIsNotNone(product.id)
        products = Product.all()
        self.assertEqual(len(products), 1)
