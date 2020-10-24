#if !canImport(ObjectiveC)
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
extension HttpMethodTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension HTTPTestCase {
	static var allTests = [
		("testQueryParam", testQueryParam),
		("testJSONParam", testJSONParam),
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
		("testHttpRequest", testHttpRequest),
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
		("testRegex", testRegex),
	]
}
extension CacheStorageTestCase {
	static var allTests = [
		("testNSCacheStorage", testNSCacheStorage),
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
		("testStorageManager", testStorageManager),
	]
}
extension StringTestCase {
	static var allTests = [
		("testNumberConvertable", testNumberConvertable),
		("testStringExtensions", testStringExtensions),
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
extension NSRegularExpressionTestCase {
	static var allTests = [
		("testNSRegularExpression", testNSRegularExpression),
	]
}
extension UIntTestCase {
	static var allTests = [
		("testNumberConvertable", testNumberConvertable),
	]
}
extension ArrayTestCase {
	static var allTests = [
		("testArrayExtension", testArrayExtension),
	]
}
extension NSObjectTestCase {
	static var allTests = [
		("testNSOBject", testNSOBject),
	]
}
extension CharacterTestCase {
	static var allTests = [
		("testCharacter", testCharacter),
	]
}
extension DictionaryTestCase {
	static var allTests = [
		("testDictonary", testDictonary),
		("testDictionaryWithArrayBuilder", testDictionaryWithArrayBuilder),
	]
}
extension DataTestCase {
	static var allTests = [
		("testInitWithHex", testInitWithHex),
		("testEncoding", testEncoding),
	]
}
extension NSRangeTestCase {
	static var allTests = [
		("testIsValid", testIsValid),
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
		("testSorting", testSorting),
		("testSortingLargeArray", testSortingLargeArray),
		("testSortingDuplicatedArray", testSortingDuplicatedArray),
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
		("testCalculator", testCalculator),
	]
}
extension BinaryTreeProtocolTestCase {
	static var allTests = [
		("testBinaryTree", testBinaryTree),
	]
}
extension DirectedGraphTestCase {
	static var allTests = [
		("testDirectedGraph", testDirectedGraph),
		("testLeetcode997", testLeetcode997),
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
extension TrieTestCase {
	static var allTests = [
		("testTrie", testTrie),
		("testInsertNumberWithTrie", testInsertNumberWithTrie),
		("testInsertNumberWithDictionary", testInsertNumberWithDictionary),
		("testInsertNumberWithRedBlackTree", testInsertNumberWithRedBlackTree),
		("testTrie3", testTrie3),
		("testScanProject", testScanProject),
	]
}
extension GraphProtocolTestCase {
	static var allTests = [
		("testGraph", testGraph),
	]
}
extension BitArrayTestCase {
	static var allTests = [
		("testBitArray", testBitArray),
		("testBitArrayPerformance", testBitArrayPerformance),
		("testSetPerformance", testSetPerformance),
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
extension GraphTestCase {
	static var allTests = [
		("testGraph", testGraph),
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
		("testDataStorageStrategy", testDataStorageStrategy),
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
		("testConfigurable", testConfigurable),
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
		("testFileLogger", testFileLogger),
	]
}
extension DebugLoggerTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension JSONObjectTestCase {
	static var allTests = [
		("testJSONObject", testJSONObject),
	]
}
extension CodeLocationTestCase {
	static var allTests = [
		("testCodeLocation", testCodeLocation),
	]
}
extension DynamicObjectTestCase {
	static var allTests = [
		("testMathObject", testMathObject),
		("testDynamicObject", testDynamicObject),
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
		("testDefault", testDefault),
	]
}
extension AssociatedPropertyTestCase {
	static var allTests = [
		("testSample", testSample),
	]
}
extension BuilderTestCase {
	static var allTests = [
		("testBuilder", testBuilder),
	]
}
extension ArrayBuilderTestCase {
	static var allTests = [
		("testArrayWithOneItem", testArrayWithOneItem),
		("testArrayWithMoreThanOneItem", testArrayWithMoreThanOneItem),
		("testArrayBuilder", testArrayBuilder),
	]
}
extension LocalizationTestCase {
	static var allTests = [
		("testLocalization", testLocalization),
	]
}
public func allTests() -> [XCTestCaseEntry] {
	return [
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
		testCase(NSRegularExpressionTestCase.allTests),
		testCase(UIntTestCase.allTests),
		testCase(ArrayTestCase.allTests),
		testCase(NSObjectTestCase.allTests),
		testCase(CharacterTestCase.allTests),
		testCase(DictionaryTestCase.allTests),
		testCase(DataTestCase.allTests),
		testCase(NSRangeTestCase.allTests),
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
		testCase(DirectedGraphTestCase.allTests),
		testCase(NodeTestCase.allTests),
		testCase(QueueTestCase.allTests),
		testCase(TrieTestCase.allTests),
		testCase(GraphProtocolTestCase.allTests),
		testCase(BitArrayTestCase.allTests),
		testCase(BagTestCase.allTests),
		testCase(BinaryTreeTestCase.allTests),
		testCase(PriorityQueueTestCase.allTests),
		testCase(GraphTestCase.allTests),
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
