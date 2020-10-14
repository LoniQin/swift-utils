#if !canImport(ObjectiveC)
extension StorageTests {
	static var allTests = [
		("testFileStorage", testFileStorage),
		("testFileStorage2", testFileStorage2),
		("testFileStorageWithLargeData", testFileStorageWithLargeData),
	]
}
extension BuildderTests {
	static var allTests = [
		("testBuilderBlock", testBuilderBlock),
	]
}
extension CollectionTests {
	static var allTests = [
		("testNode", testNode),
		("testStack", testStack),
		("testStackPerformance", testStackPerformance),
		("testQueue", testQueue),
		("testQueuePerformance", testQueuePerformance),
		("testArrayPerformance", testArrayPerformance),
		("testBag", testBag),
		("testPriorityQueue", testPriorityQueue),
		("testAppendAndRemoveRandomQueue", testAppendAndRemoveRandomQueue),
		("testFixSizedPriorityQueue", testFixSizedPriorityQueue),
		("testRedBlackTree", testRedBlackTree),
		("testRedBlackTree2", testRedBlackTree2),
	]
}
extension FoundationLibTests {
	static var allTests = [
		("testUnwrappable", testUnwrappable),
		("testDipatchQueue", testDipatchQueue),
		("testNumberConvertable", testNumberConvertable),
		("testMemoryCacheManager", testMemoryCacheManager),
		("testUserDefaults", testUserDefaults),
		("testFileStorage", testFileStorage),
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
		("testCodeLocation", testCodeLocation),
	]
}
extension CryptoTests {
	static var allTests = [
		("testBruteForce", testBruteForce),
		("testSymmetricCipherWithHelloWorld", testSymmetricCipherWithHelloWorld),
		("testInRandom", testInRandom),
		("testIsAlgorithmVaild", testIsAlgorithmVaild),
		("testIsIVNeeded", testIsIVNeeded),
		("testDigests", testDigests),
		("testAES128", testAES128),
		("testAES192", testAES192),
		("testAES256", testAES256),
		("testSHA256", testSHA256),
		("testHMACSHA256", testHMACSHA256),
		("testHMAC", testHMAC),
		("testStringProcessWithCipher", testStringProcessWithCipher),
		("testStringProcessWithDigest", testStringProcessWithDigest),
		("testIVSize", testIVSize),
		("testStringProcessWithHMAC", testStringProcessWithHMAC),
		("testChangeEncoding", testChangeEncoding),
	]
}
extension ExtensionsTest {
	static var allTests = [
		("testNSOBjectExtension", testNSOBjectExtension),
		("testInt", testInt),
		("testFloat", testFloat),
		("testDouble", testDouble),
		("testUInt", testUInt),
		("testString", testString),
		("testDispatchQueue", testDispatchQueue),
		("testNumericExtension", testNumericExtension),
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
extension CompressorTests {
	static var allTests = [
		("testCompressorAlgorithm", testCompressorAlgorithm),
		("testCompresorOperation", testCompresorOperation),
		("testCompression", testCompression),
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
public func allTests() -> [XCTestCaseEntry] {
	return [
		testCase(StorageTests.allTests),
		testCase(BuildderTests.allTests),
		testCase(CollectionTests.allTests),
		testCase(FoundationLibTests.allTests),
		testCase(CryptoTests.allTests),
		testCase(ExtensionsTest.allTests),
		testCase(SortingTests.allTests),
		testCase(ProtocolsTest.allTests),
		testCase(CompressorTests.allTests),
		testCase(NetworkingTests.allTests),
	]
}
#endif
