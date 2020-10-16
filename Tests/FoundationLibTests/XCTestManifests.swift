#if !canImport(ObjectiveC)
extension StorageTests {
	static var allTests = [
	]
}
extension FoundationLibTests {
	static var allTests = [
		("testDefault", testDefault),
		("testStringExtensions", testStringExtensions),
		("testAssert", testAssert),
		("testDictonaryExtension", testDictonaryExtension),
		("testArrayExtension", testArrayExtension),
		("testNSCacheStorage", testNSCacheStorage),
		("testBuider", testBuider),
		("testRegex", testRegex),
		("testStorageManager", testStorageManager),
		("testFileLogger", testFileLogger),
		("testArrayBuilder", testArrayBuilder),
		("testDictionaryWithArrayBuilder", testDictionaryWithArrayBuilder),
		("testJSONObject", testJSONObject),
		("testKeyPathConfigurable", testKeyPathConfigurable),
		("testLocalization", testLocalization),
		("testDynamicObject", testDynamicObject),
		("testMathObject", testMathObject),
	]
}
extension SortingTests {
	static var allTests = [
		("testSorting", testSorting),
		("testSortingLargeArray", testSortingLargeArray),
		("testSortingDuplicatedArray", testSortingDuplicatedArray),
	]
}
extension ProtocolsTest {
	static var allTests = [
		("testDataStorageStrategy", testDataStorageStrategy),
	]
}
extension NetworkingTests {
	static var allTests = [
		("testQueryParam", testQueryParam),
		("testJSONParam", testJSONParam),
		("testHttpRequest", testHttpRequest),
		("testSendAndReceiveRequest1", testSendAndReceiveRequest1),
		("testSendAndReceiveRequest2", testSendAndReceiveRequest2),
		("testHttpClientWithHttpRequest", testHttpClientWithHttpRequest),
		("testHttpClientWithURLAndURLRequest", testHttpClientWithURLAndURLRequest),
		("testHttpClientWithURL", testHttpClientWithURL),
		("testGetMockUser", testGetMockUser),
		("testDataConvertable", testDataConvertable),
		("testForm", testForm),
		("testProcessOptions", testProcessOptions),
		("testDownloadImage", testDownloadImage),
	]
}
extension SymmetricCipherTestCase {
	static var allTests = [
		("testBruteForce", testBruteForce),
		("testSymmetricCipherWithHelloWorld", testSymmetricCipherWithHelloWorld),
		("testInRandom", testInRandom),
		("testIsAlgorithmVaild", testIsAlgorithmVaild),
		("testAES128", testAES128),
		("testAES192", testAES192),
		("testAES256", testAES256),
		("testSHA256", testSHA256),
		("testIVSize", testIVSize),
		("testIsIVNeeded", testIsIVNeeded),
	]
}
extension ProcessOptionsTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension HMACTestCase {
	static var allTests = [
		("testHMACSHA256", testHMACSHA256),
		("testHMAC", testHMAC),
	]
}
extension DigestTestCase {
	static var allTests = [
		("testDigests", testDigests),
	]
}
extension Data_CryptoTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension CCErrorTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension CryptoErrorTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension String_CryptoTestCase {
	static var allTests = [
		("testStringProcessWithCipher", testStringProcessWithCipher),
		("testStringProcessWithDigest", testStringProcessWithDigest),
		("testStringProcessWithHMAC", testStringProcessWithHMAC),
		("testChangeEncoding", testChangeEncoding),
	]
}
extension HttpClientTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension HttpMethodTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension HTTPTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension ContentTypeTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension DictionaryGeneratorTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension HttpRequestTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension QueryGeneratorTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension FormTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension NetworkingErrorTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension URLSessionTaskProtocolTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension JSONTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension RegexTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension CacheStorageTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension FileStorageTestCase {
	static var allTests = [
		("testFileStorage", testFileStorage),
		("testFileStorage2", testFileStorage2),
		("testFileStorage3", testFileStorage3),
		("testFileStorageWithLargeData", testFileStorageWithLargeData),
	]
}
extension DictionaryStorageTestCase {
	static var allTests = [
		("testDictionaryStorage", testDictionaryStorage),
	]
}
extension DataStoreManagerTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension StringTestCase {
	static var allTests = [
		("testString", testString),
	]
}
extension NSLockTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension NumericTestCase {
	static var allTests = [
		("testNumericExtension", testNumericExtension),
	]
}
extension FloatTestCase {
	static var allTests = [
		("testFloat", testFloat),
	]
}
extension UserDefaultsTestCase {
	static var allTests = [
		("testUserDefaults", testUserDefaults),
	]
}
extension DispatchQueueTestCase {
	static var allTests = [
		("testDispatchQueue", testDispatchQueue),
	]
}
extension UIntTestCase {
	static var allTests = [
		("testUInt", testUInt),
	]
}
extension ArrayTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension NSObjectTestCase {
	static var allTests = [
		("testNSOBject", testNSOBject),
	]
}
extension DictionaryTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension DataTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension DoubleTestCase {
	static var allTests = [
		("testDouble", testDouble),
	]
}
extension FileManagerTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension ComparableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension IntTestCase {
	static var allTests = [
		("testInt", testInt),
	]
}
extension CompressorTestCase {
	static var allTests = [
		("testCompressorAlgorithm", testCompressorAlgorithm),
		("testCompresorOperation", testCompresorOperation),
		("testCompression", testCompression),
	]
}
extension CompressionErrorTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension Array_SortingTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension SortingAlgorithmTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension RedBlackTreeTestCase {
	static var allTests = [
		("testRedBlackTree", testRedBlackTree),
		("testRedBlackTree2", testRedBlackTree2),
	]
}
extension StackTestCase {
	static var allTests = [
		("testStack", testStack),
		("testStackPerformance", testStackPerformance),
	]
}
extension BinaryTreeProtocolTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension NodeTestCase {
	static var allTests = [
		("testNode", testNode),
	]
}
extension QueueTestCase {
	static var allTests = [
		("testQueue", testQueue),
		("testQueuePerformance", testQueuePerformance),
	]
}
extension BagTestCase {
	static var allTests = [
		("testBag", testBag),
	]
}
extension BinaryTreeTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension PriorityQueueTestCase {
	static var allTests = [
		("testPriorityQueue", testPriorityQueue),
		("testAppendAndRemoveRandomQueue", testAppendAndRemoveRandomQueue),
	]
}
extension FixedSizePriorityQueueTestCase {
	static var allTests = [
		("testFixSizedPriorityQueue", testFixSizedPriorityQueue),
	]
}
extension NetworkingTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension DataStorageTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension CountableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension LoggingTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension ConfigurableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension DynamicMemberLookupableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension ValidatableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension DynamicNewableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension DataConvertableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension HttpHeaderConvertableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension StringConvertableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension NumberConvertableTestCase {
	static var allTests = [
		("testNumberConvertable", testNumberConvertable),
	]
}
extension ResponseConvertableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension RequestConvertableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension SuspendableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension ResumableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension CancellableTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension UnwrappableTestCase {
	static var allTests = [
		("testUnwrappable", testUnwrappable),
	]
}
extension FileLoggerTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension DebugLoggerTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension JSONObjectTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension CodeLocationTestCase {
	static var allTests = [
		("testCodeLocation", testCodeLocation),
	]
}
extension DynamicObjectTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension EncodingTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension FoundationErrorTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension DefaultTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension AssociatedPropertyTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension BuilderTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension ArrayBuilderTestCase {
	static var allTests = [
		("testArrayWithOneItem", testArrayWithOneItem),
		("testArrayWithMoreThanOneItem", testArrayWithMoreThanOneItem),
	]
}
extension LocalizationTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
public func allTests() -> [XCTestCaseEntry] {
	return [
		testCase(StorageTests.allTests),
		testCase(FoundationLibTests.allTests),
		testCase(SortingTests.allTests),
		testCase(ProtocolsTest.allTests),
		testCase(NetworkingTests.allTests),
		testCase(SymmetricCipherTestCase.allTests),
		testCase(ProcessOptionsTestCase.allTests),
		testCase(HMACTestCase.allTests),
		testCase(DigestTestCase.allTests),
		testCase(Data_CryptoTestCase.allTests),
		testCase(CCErrorTestCase.allTests),
		testCase(CryptoErrorTestCase.allTests),
		testCase(String_CryptoTestCase.allTests),
		testCase(HttpClientTestCase.allTests),
		testCase(HttpMethodTestCase.allTests),
		testCase(HTTPTestCase.allTests),
		testCase(ContentTypeTestCase.allTests),
		testCase(DictionaryGeneratorTestCase.allTests),
		testCase(HttpRequestTestCase.allTests),
		testCase(QueryGeneratorTestCase.allTests),
		testCase(FormTestCase.allTests),
		testCase(NetworkingErrorTestCase.allTests),
		testCase(URLSessionTaskProtocolTestCase.allTests),
		testCase(JSONTestCase.allTests),
		testCase(RegexTestCase.allTests),
		testCase(CacheStorageTestCase.allTests),
		testCase(FileStorageTestCase.allTests),
		testCase(DictionaryStorageTestCase.allTests),
		testCase(DataStoreManagerTestCase.allTests),
		testCase(StringTestCase.allTests),
		testCase(NSLockTestCase.allTests),
		testCase(NumericTestCase.allTests),
		testCase(FloatTestCase.allTests),
		testCase(UserDefaultsTestCase.allTests),
		testCase(DispatchQueueTestCase.allTests),
		testCase(UIntTestCase.allTests),
		testCase(ArrayTestCase.allTests),
		testCase(NSObjectTestCase.allTests),
		testCase(DictionaryTestCase.allTests),
		testCase(DataTestCase.allTests),
		testCase(DoubleTestCase.allTests),
		testCase(FileManagerTestCase.allTests),
		testCase(ComparableTestCase.allTests),
		testCase(IntTestCase.allTests),
		testCase(CompressorTestCase.allTests),
		testCase(CompressionErrorTestCase.allTests),
		testCase(Array_SortingTestCase.allTests),
		testCase(SortingAlgorithmTestCase.allTests),
		testCase(RedBlackTreeTestCase.allTests),
		testCase(StackTestCase.allTests),
		testCase(BinaryTreeProtocolTestCase.allTests),
		testCase(NodeTestCase.allTests),
		testCase(QueueTestCase.allTests),
		testCase(BagTestCase.allTests),
		testCase(BinaryTreeTestCase.allTests),
		testCase(PriorityQueueTestCase.allTests),
		testCase(FixedSizePriorityQueueTestCase.allTests),
		testCase(NetworkingTestCase.allTests),
		testCase(DataStorageTestCase.allTests),
		testCase(CountableTestCase.allTests),
		testCase(LoggingTestCase.allTests),
		testCase(ConfigurableTestCase.allTests),
		testCase(DynamicMemberLookupableTestCase.allTests),
		testCase(ValidatableTestCase.allTests),
		testCase(DynamicNewableTestCase.allTests),
		testCase(DataConvertableTestCase.allTests),
		testCase(HttpHeaderConvertableTestCase.allTests),
		testCase(StringConvertableTestCase.allTests),
		testCase(NumberConvertableTestCase.allTests),
		testCase(ResponseConvertableTestCase.allTests),
		testCase(RequestConvertableTestCase.allTests),
		testCase(SuspendableTestCase.allTests),
		testCase(ResumableTestCase.allTests),
		testCase(CancellableTestCase.allTests),
		testCase(UnwrappableTestCase.allTests),
		testCase(FileLoggerTestCase.allTests),
		testCase(DebugLoggerTestCase.allTests),
		testCase(JSONObjectTestCase.allTests),
		testCase(CodeLocationTestCase.allTests),
		testCase(DynamicObjectTestCase.allTests),
		testCase(EncodingTestCase.allTests),
		testCase(FoundationErrorTestCase.allTests),
		testCase(DefaultTestCase.allTests),
		testCase(AssociatedPropertyTestCase.allTests),
		testCase(BuilderTestCase.allTests),
		testCase(ArrayBuilderTestCase.allTests),
		testCase(LocalizationTestCase.allTests),
	]
}
#endif
